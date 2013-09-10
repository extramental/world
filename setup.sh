pushd neuron/server
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
initialize_cerebro_db cerebro/development.ini
