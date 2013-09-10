trap exit SIGINT

if [ "x$VIRTUAL_ENV" = x ]; then
    echo "Please create a Python virtual environment before continuing."
    exit 1;
fi

echo "Cloning submodules..."
git submodule init
git submodule update --remote

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

echo "Installing Bower dependencies..."
pushd cerebro/cerebro/static/js
bower install

echo "Building SockJS-Client..."
pushd bower_components/sockjs-client
npm install
echo "cat version" > VERSION-GEN
make build
popd
popd

echo "Setting up Postgres for the first time..."
createdb -hlocalhost cerebro-development

echo "Initializing Cerebro database..."
initialize_cerebro_db config/development.cerebro.ini
