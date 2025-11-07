Create the models for a Magic: The Gathering card database.To create the models for a Magic: The Gathering card database, we can define a few key models such as Card, Deck and DeckCard.
Use the  the CSV file `magic_cards.csv` to model the Card model, the model Deck must have a name and the model DeckCard must have only the foreign keys between Card and Deck.

Once the models are created import the cards from the file `magic_cards.csv` to the table `cards`, crete a rake task to do that. Also generate a seed that create the three decks with the names "Death and Taxes", "Tron" and "Goblins", then associate 60 cardss at random to each deck.

When the data is imported create a index on a Elasticsearch instance running on port 9200 with the name `cards`, then index every card present in the database on cards index. The structure of the index must be the same of the Card model. Create a rake task that index every card present on cards table to the new index called `cards`.

Configure JSON API format and create the controllers cards and decks with the following actions:
1. cards:
    - search: must use elasticsearch index to fetch the cards, use JSON API format;
2. decks:
    - show: show the deck and the list of related cards
    - show: a list with Decks and the count of related cards sorted by name asc;
3. deck_cards:
    - create: POST request thar receive a card_id and a deck_id and relate both cards
