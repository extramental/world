trap exit SIGINT

if [ "x$VIRTUAL_ENV" = x ]; then
    echo "Please create a Python virtual environment before continuing."
    exit 1;
fi

git submodule init
git submodule update

echo "Installing Python dependencies..."
pip install -r requirements.txt

python neuron/setup.py develop
python cerebro/setup.py develop

echo "Installing global Node.js dependencies..."
sudo npm install -g uglify-js less bower

echo "Setting up Postgres for the first time..."
createdb -hlocalhost cerebro-development

echo "Initializing Cerebro database..."
initialize_cerebro_db config/development.ini
