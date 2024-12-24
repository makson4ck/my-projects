let randomNumber = Math.floor(Math.random() * 100) + 1;
let attempts = 0;

const guessInput = document.getElementById('guess');
const checkBtn = document.getElementById('check-btn');
const restartBtn = document.getElementById('restart-btn');
const resultDisplay = document.getElementById('result');
const instructions = document.getElementById('instructions');

checkBtn.addEventListener('click', () => {
    const userGuess = parseInt(guessInput.value);

    if (isNaN(userGuess) || userGuess < 1 || userGuess > 100) {
        resultDisplay.textContent = 'Введите число от 1 до 100! / Enter a number from 1 to 100!';
        resultDisplay.style.color = 'red';
        return;
    }

    attempts++;

    if (userGuess === randomNumber) {
        resultDisplay.textContent = `Поздравляем! Вы угадали число ${randomNumber} за ${attempts} попыток!  /  Congratulations! You guessed ${randomNumber} in ${attempts} attempts!`;
        resultDisplay.style.color = 'green';
        checkBtn.classList.add('hidden');
        restartBtn.classList.remove('hidden');
    } else if (userGuess < randomNumber) {
        resultDisplay.textContent = 'Загаданное число больше! / The hidden number is greater!';
        resultDisplay.style.color = 'blue';
    } else {
        resultDisplay.textContent = 'Загаданное число меньше! / The hidden number is less!';
        resultDisplay.style.color = 'blue';
    }

    guessInput.value = '';
});

restartBtn.addEventListener('click', () => {
    randomNumber = Math.floor(Math.random() * 100) + 1;
    attempts = 0;
    guessInput.value = '';
    resultDisplay.textContent = '';
    instructions.textContent = 'Я загадал число от 1 до 100. Сможешь угадать? / I guessed a number from 1 to 100. Can you guess?';
    checkBtn.classList.remove('hidden');
    restartBtn.classList.add('hidden');
});