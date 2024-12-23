let currentInput = "0";
let expression = "";
const numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
const operators = ['+', '×', '-', '/'];
const output = document.querySelector(".text p");

function clearAll() {
    currentInput = "0";
    expression = "";
    output.textContent = currentInput;
}

document.querySelector('.ac').onclick = clearAll;

document.querySelector(".buttons").onclick = (event) => {
    if (!event.target.classList.contains('btn')) return;
    const key = event.target.textContent;

    if (key === "←") {
        if (currentInput.length > 1) {
            currentInput = currentInput.slice(0, -1);
            expression = expression.slice(0, -1);
        } else {
            currentInput = "0";
            expression = "";
        }
        output.textContent = currentInput;
        return;
    }

    if (numbers.includes(key) || operators.includes(key)) {
        if (key === "×") {
            expression += "*";
        } else {
            expression += key;
        }

        if (currentInput === "0" && key !== ".") {
            currentInput = key;
        } else {
            currentInput += key;
        }

        output.textContent = currentInput;
    }

    if (key === "=") {
        try {
            let result = eval(expression);
            currentInput = result.toString();
            expression = currentInput;
        } catch (error) {
            currentInput = "Error";
        }

        output.textContent = currentInput;
    }

    if (key === "+/-") {
        currentInput = (parseFloat(currentInput) * -1).toString();
        expression = currentInput;
        output.textContent = currentInput;
    }

    if (operators.includes(key)) {
        if (expression.length > 0 && !operators.includes(expression[expression.length - 1])) {
            expression += key;
        }
    }
}