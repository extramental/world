trap exit SIGINT;

if [ "x$VIRTUAL_ENV" = x ]; then
    echo "Please create a Python virtual environment before continuing."
    exit 1;
fi

echo "Installing Python dependencies..."
pip install -r requirements.txt

pushd neuron
python setup.py develop
popd

pushd cerebro
python setup.py develop
popd

echo "Installing global Node.js dependencies..."
sudo npm install -g uglify-js less bower

echo "Setting up Postgres for the first time..."
createdb -hlocalhost cerebro-development

echo "Initializing Cerebro database..."
initialize_cerebro_db config/development.ini
