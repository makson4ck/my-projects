const lengthInput = document.getElementById('length');
const uppercaseCheckbox = document.getElementById('uppercase');
const numbersCheckbox = document.getElementById('numbers');
const symbolsCheckbox = document.getElementById('symbols');
const passwordInput = document.getElementById('password');
const generateButton = document.getElementById('generate-btn');
const copyButton = document.getElementById('copy-btn');

const uppercaseChars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
const lowercaseChars = 'abcdefghijklmnopqrstuvwxyz';
const numberChars = '0123456789';
const symbolChars = '!@#$%^&*()_+[]{}<>?,./';

function generatePassword() {
    const length = parseInt(lengthInput.value) || 12;
    let characterPool = lowercaseChars;

    if (uppercaseCheckbox.checked) characterPool += uppercaseChars;
    if (numbersCheckbox.checked) characterPool += numberChars;
    if (symbolsCheckbox.checked) characterPool += symbolChars;

    if (characterPool === '') {
        alert('Please select at least one character type!/Выберите хотя бы один тип символов!');
        return '';
    }

    let password = '';
    for (let i = 0; i < length; i++) {
        const randomIndex = Math.floor(Math.random() * characterPool.length);
        password += characterPool[randomIndex];
    }
    return password;
}

generateButton.addEventListener('click', () => {
    passwordInput.value = generatePassword();
});

copyButton.addEventListener('click', () => {
    if (!passwordInput.value) {
        alert('Nothing to copy!/Нечего копировать!');
        return;
    }
    navigator.clipboard.writeText(passwordInput.value);
    alert('Password copied to clipboard!/Пароль скопирован в буфер обмена!');
});