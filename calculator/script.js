let text = "0";
let text_decision = "";
const numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.'];
const action = ['+', '×', '-', '/'];
const out = document.querySelector(".text p");

function clearall() {
    text = "0";
    text_decision = "";
    out.textContent = text;
}

document.querySelector('.ac').onclick = clearall;

document.querySelector(".buttons").onclick = (event) => {
    if (!event.target.classList.contains('btn')) return;
    if (event.target.classList.contains('ac')) return;
    const key = event.target.textContent;

    if (numbers.includes(key) || action.includes(key)) {
        if (key === "×") {
            text_decision += "*"; 
        } else {
            text_decision += key;
        }

        // Обновление экрана
        if (text !== "0") {
            text += key;
        } else if (text === "0") {
            text = key;
        }
        out.textContent = text;
    }

    if (key === "=") {
        try {
            text = eval(text_decision).toString();
            text_decision = text;
        } catch (error) {
            text = "Ошибка";
        }
        out.textContent = text;
    }

    if (key === "←") {
        if (text.length > 1) {
            text = text.slice(0, -1);
            text_decision = text_decision.slice(0, -1);
        } else {
            text = "0";
            text_decision = "";
        }
        out.textContent = text;
    }

    if (key === "+/-") {
        text = (parseFloat(text) * -1).toString();
        text_decision = text;
        out.textContent = text;
    }
}
