from flask import Flask

app = Flask(__name__)

@app.route("/")
def food_court():
    return """
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Welcome to Food Court</title>
        <style>
            body {
                font-family: 'Arial', sans-serif;
                margin: 0;
                padding: 0;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background: #fff;
                background-image: url('https://www.transparenttextures.com/patterns/food.png');
                background-color: #f9f3e9;
                color: #333;
                text-align: center;
            }

            .container {
                background: rgba(255, 255, 255, 0.9);
                padding: 40px;
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                text-align: center;
                transform: scale(1);
                transition: transform 0.3s ease;
            }

            .container:hover {
                transform: scale(1.05);
            }

            h1 {
                font-size: 3.5rem;
                color: #ff6f61;
                text-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
                margin-bottom: 20px;
            }

            p {
                font-size: 1.5rem;
                color: #555;
            }

            .button {
                margin-top: 20px;
                padding: 15px 30px;
                font-size: 1.5rem;
                color: #fff;
                background: linear-gradient(90deg, #ff6f61, #de6161);
                border: none;
                border-radius: 50px;
                cursor: pointer;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .button:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Welcome to Food Court</h1>
            <p>Indulge in flavors from around the world!</p>
            <button class="button" onclick="alert('Bon Appétit!')">Explore Now</button>
        </div>
    </body>
    </html>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
