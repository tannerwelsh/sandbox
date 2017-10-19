# schema

Flashcardinator
	Card
		term
		definition
	Deck < Array
		cards
	User
		guesses
	Guess
		card_id
		correctness
	UI
		run
		show_card
		get_guess

Flashcardinator::UI.run
UI.show_card
	UI.show_term
		card.show_term
	UI.show_definition
	UI.guess
UI.end