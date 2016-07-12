# balance-sheet
A basic, personal accounting project. Very much akin to a personal checkbook.

## Application Architecture

### LineItems

*
We are all set! Run your Phoenix application:

    $ cd balance_sheet
    $ mix phoenix.server

You can also run your app inside IEx (Interactive Elixir) as:

    $ iex -S mix phoenix.server

Before moving on, configure your database in config/dev.exs and run:

    $ mix ecto.create


Phoenix uses an optional assets build tool called brunch.io
that requires node.js and npm. Installation instructions for
node.js, which includes npm, can be found at http://nodejs.org.

After npm is installed, install your brunch dependencies by
running inside your app:

    $ npm install

I f you don't want brunch.io, you can re-run this generator
with the --no-brunch option.

# Data Model
Line Items - Actual Entries being balanced
  * Classification (Check Number, DC, AD, etc)
  * Created At
  * Pending-+---State?
  * Cleared-|
  * Tip Amount?
  *

Category
  * Name

Tag:
 * Name

In order to structure the funds we move around for our envelope method of saving, we need identifiers that we can guage progress on other goals with.
