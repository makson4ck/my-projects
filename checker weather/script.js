const apiKey = '50a3953d8a3637882f3dfd038705bf79';  // How to get he? Как взять его? https://youtu.be/MmjZ-nly4sA

function getWeather() {
    const city = document.getElementById('city').value;
    if (!city) {
        alert('Пожалуйста, введите город');
        return;
    }
    
    const url = `https://api.openweathermap.org/data/2.5/weather?q=${city}&appid=${apiKey}&units=metric&lang=ru`;
    
    fetch(url)
        .then(response => response.json())
        .then(data => {
            if (data.cod === 200) {
                const temperature = data.main.temp;
                const description = data.weather[0].description;
                const humidity = data.main.humidity;
                const windSpeed = data.wind.speed;
                
                document.getElementById('temperature').textContent = `Температура: ${temperature}°C`;
                document.getElementById('description').textContent = `Описание: ${description}`;
                document.getElementById('humidity').textContent = `Влажность: ${humidity}%`;
                document.getElementById('wind-speed').textContent = `Скорость ветра: ${windSpeed} м/с`;
            } else {
                alert('Город не найден. Попробуйте еще раз.');
            }
        })
        .catch(error => {
            console.error('Ошибка:', error);
            alert('Произошла ошибка при загрузке данных.');
        });
}