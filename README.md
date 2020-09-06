# Banking-API

## Install on your machine
### Clone the repository

```shell
git clone git@github.com:lokhi/banking_api.git
cd banking_api
```

### Check your Ruby version

```shell
ruby -v
```

The ouput should start with something like `ruby 2.6.6`

If not, install the right ruby version using [rvm](https://github.com/rvm/rvm) (it could take a while):

```shell
rvm install 2.6.6
```

### Install dependencies

Using [Bundler](https://github.com/bundler/bundler)

```shell
bundle install --without production
```
### Set environment variables
This project use the [fixer.io](https://fixer.io) API. You must register to get a free API KEY
```shell
export FIXER_KEY_API="APIKEY"
```
##### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```
##### 4. Start the Rails server

You can start the rails server using the command given below.

```ruby
bundle exec rails s
```

And now you can reach the different api with the  BASE URL http://localhost:3000


## Test
You wan launch test with the following command
```ruby
bundle exec rspec
```

## API Documentation

```GET /v1/wallets```
+ Description: List all wallets of a company
+ Body parameters:
    + None
+ Header parameter:
  + Company-Id: An integer different from 1
  + User-Id: A positif integer
+ Example:
```shell
curl --request GET \
  --url http://localhost:3000/v1/wallets \
  --header 'company-id: 1' \
  --header 'content-type: application/json' \
  --header 'user-id: 1'
```

```POST /v1/wallets```
+ Description: Create a new wallet for a company
+ Body parameters:
    + wallet[current_balance]: Amount of money you want to initialize the wallet it should be a positif float
    + wallet[currency]: Currency of the wallet. It can be *USD*, *EUR* or *GBP*. Warning it's case sensitive
+ Header parameter:
    + Company-Id: A positif integer different from 1
    + User-Id: A positif integer
+ Example:
```shell
curl --request POST \
  --url http://localhost:3000/v1/wallets \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1' \
  --data '{
	"wallet":{
		"current_balance":1000,
		"currency":"EUR"
	}
}'
```


```GET /v1/cards```
+ Description: List all cards of an user
+ Body parameters:
    + None
+ Header parameter:
  + User-Id: A positif different from 1
+ Example:
```shell
curl --request GET \
  --url http://localhost:3000/v1/cards \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1'
```



```POST /v1/cards```
+ Description: Create a new card from a wallet for an user
+ Body parameters:
    + card[wallet_id]: Id of the wallet this card is associated to.
+ Header parameter:
    + Company-Id: A positif integer different from 1
    + User-Id: A positif integer
+ Example:
```shell
curl --request POST \
  --url http://localhost:3000/v1/cards \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1' \
  --data '{
	"card":{
		"wallet_id":4
	}
}'
```

```PATCH /v1/card/:id/load```
+ Description: Load money to card from its wallet.
+ Url parameters:
    + id: Id of the card to which money will be loaded.
+ Body parameters:
    + amount: Amount to load to card.
+ Header parameter:
    + Company-Id: A positif integer different from 1
    + User-Id: A positif integer equal to the user_id of the card
+ Example:
```shell
curl --request PATCH \
  --url http://localhost:3000/v1/cards/1/load \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1' \
  --data '{"amount":50}'
```

```PATCH /v1/card/:id/load```
+ Description: Unload money from card to its wallet.
+ Url parameters:
    + id: Id of the card to which money will be loaded.
+ Body parameters:
    + amount: Amount to unload from card.
+ Header parameter:
    + Company-Id: A positif integer different from 1
    + User-Id: A positif integer equal to the user_id of the card
+ Example:
```shell
curl --request PATCH \
  --url http://localhost:3000/v1/cards/1/unload \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1' \
  --data '{"amount":50}'
```

```PATCH /v1/card/:id/lock```
+ Description: Lock the card and transfer the current_balance to its wallet.
+ Url parameters:
    + id: Id of the card to be blocked.
+ Header parameter:
    + Company-Id: A positif integer different from 1
    + User-Id: A positif integer equal to the user_id of the card
+ Example:
```shell
curl --request PATCH \
  --url http://localhost:3000/v1/cards/1/lock \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1'
```

```PATCH /v1/card/:id/unlock```
+ Description: Unlock the card.
+ Url parameters:
    + cardId: Id of the card to be unblocked.
+ Header parameter:
    + Company-Id: A positif integer different from 1
    + User-Id: A positif integer equal to the user_id of the card
+ Example:
```shell
curl --request PATCH \
  --url http://localhost:3000/v1/cards/1/unlock \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1'
```

```PATCH /v1/wallets/:origin_wallet/to/:target_wallet```
+ Description: Transfer money between 2 wallets
+ Url parameters:
    + origin_wallet: Id of the origin wallet
    + target_wallet: Id of the target wallet
+ Body parameters:
    + amount: Amount of money to transfer between wallets
+ Header parameter:
    + Company-Id: A positif integer equal to the company_id of both wallets
    + User-Id: A positif integer equal to the user_id of the card
+ Example:
```shell
curl --request PATCH \
  --url http://localhost:3000/v1/wallets/4/to/5 \
  --header 'company-id: 2' \
  --header 'content-type: application/json' \
  --header 'user-id: 1' \
  --data '{"amount": 50}'
```
