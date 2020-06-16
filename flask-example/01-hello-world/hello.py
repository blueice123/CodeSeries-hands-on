from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return "<h1>Hello, World!, Green Deployment</h1>"

@app.route('/user/<name>')
def user(name):
	return '<h1>Hello, {0}!</h1>'.format(name)

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)

