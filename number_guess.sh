#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

INPUT_NAME() {
  echo "Enter your username:"
  read USER_NAME
  LENGTH=${#USER_NAME}

  while [[ $LENGTH -gt 22 || $LENGTH -eq 0 ]]; do
    echo "Enter your username:"
    read USER_NAME
    LENGTH=${#USER_NAME}
  done

  USER_NAME=$(echo $($PSQL "SELECT username FROM users WHERE username='$USER_NAME';") | sed 's/ //g')

  if [[ -z $USER_NAME ]]; then
    # for first time user
    echo -e "\nWelcome, $USER_NAME! It looks like this is your first time here."
  else
    USER_ID=$(echo $($PSQL "SELECT user_id FROM users WHERE username='$USER_NAME';") | sed 's/ //g')
    GAME_PLAYED=$(echo $($PSQL "SELECT frequent_games FROM users WHERE user_id=$USER_ID;") | sed 's/ //g')
    BEST_GAME=$(echo $($PSQL "SELECT MIN(best_guess) FROM users LEFT JOIN games USING(user_id) WHERE user_id=$USER_ID;") | sed 's/ //g')
    echo "Welcome back, $USER_NAME! You have played $GAME_PLAYED games, and your best game took $BEST_GAME guesses."
  fi

  CORRECT_ANSWER=$((RANDOM % 1000 + 1))
  GUESS_COUNT=0
  INPUT_GUESS $USER_NAME $CORRECT_ANSWER $GUESS_COUNT
}

INPUT_GUESS() {
  USER_NAME=$1
  CORRECT_ANSWER=$2
  GUESS_COUNT=$3
  USSER_GUESS=$4

  if [[ -z $USSER_GUESS ]]; then
    echo "Guess the secret number between 1 and 1000:"
    read USSER_GUESS
  fi

  while ! [[ $USSER_GUESS =~ ^[0-9]+$ ]]; do
    echo "That is not an integer, guess again:"
    read USSER_GUESS
    ((GUESS_COUNT++))
  done

  ((GUESS_COUNT++))
  CHECK_ANSWER $USER_NAME $CORRECT_ANSWER $GUESS_COUNT $USSER_GUESS
}

CHECK_ANSWER() {
  USER_NAME=$1 
  CORRECT_ANSWER=$2 
  GUESS_COUNT=$3
  USSER_GUESS=$4

  # Asking for input each time until they input the secret number.
  while [[ $USSER_GUESS -ne $CORRECT_ANSWER ]]; do
    if [[ $USSER_GUESS -lt $CORRECT_ANSWER ]]; then
      echo "It's higher than that, guess again:"
    elif [[ $USSER_GUESS -gt $CORRECT_ANSWER ]]; then
      echo "It's lower than that, guess again:"
    fi

    read USSER_GUESS
    if ! [[ $USSER_GUESS =~ ^[0-9]+$ ]]; then
      INPUT_GUESS $USER_NAME $CORRECT_ANSWER $GUESS_COUNT $USSER_GUESS
      return
    fi

    ((GUESS_COUNT++))
  done

  # When the secret number is guessed, your script should print:
  # You guessed it in <number_of_guesses> tries. The secret number was <secret_number>.
  SAVE_USER $USER_NAME $GUESS_COUNT
  NUMBER_OF_GUESSES=$GUESS_COUNT
  SECRET_NUMBER=$CORRECT_ANSWER
  echo "You guessed it in $NUMBER_OF_GUESSES tries. The secret number was $SECRET_NUMBER. Nice job!"
}

SAVE_USER() {
  USER_NAME=$1 
  GUESS_COUNT=$2
  CHECK_NAME=$($PSQL "SELECT username FROM users WHERE username='$USER_NAME';")

  if [[ -z $CHECK_NAME ]]; then
    $PSQL "INSERT INTO users(username, frequent_games) VALUES('$USER_NAME',1);" > /dev/null
  else
    GAME_COUNT=$($PSQL "SELECT frequent_games FROM users WHERE username='$USER_NAME';")
    GAME_COUNT=$((GAME_COUNT + 1))
    $PSQL "UPDATE users SET frequent_games=$GAME_COUNT WHERE username='$USER_NAME';" > /dev/null
  fi

  SAVE_GAME $USER_NAME $GUESS_COUNT
}

SAVE_GAME() {
  USER_NAME=$1 
  NUMBER_OF_GUESSES=$2
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username='$USER_NAME';")
  $PSQL "INSERT INTO games(user_id, best_guess) VALUES($USER_ID, $NUMBER_OF_GUESSES);" > /dev/null
}

# start game
INPUT_NAME
