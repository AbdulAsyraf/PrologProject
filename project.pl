%shifting part of the program
shiftup(X, [], []).
shiftup(X, [H|T], [A|B])	:-	add(X, H, A), shiftup(X, T, B),!.
add(X, H, K)	:-	(H + X) > 126	->
					K is (H + X - 95);
					K is H + X.

shiftdown(X, [], []).
shiftdown(X, [H|T], [A|B])	:-	minus(X, H, A), shiftdown(X, T, B),!.
minus(X, H, K)	:-	(H - X) < 32	->
					K is (H - X + 95);
					K is H - X.


%en/decrypting and display
encrypt(Message, Key, Result)	:-	string_codes(Message, ToDo),
									shiftup(Key, ToDo, Done),
									string_codes(Result, Done).
									
decrypt(Message, Key, Result)	:-	string_codes(Message, ToDo),
									shiftdown(Key, ToDo, Done),
									string_codes(Result, Done).
									
%user interaction part
run	:-	writeln("Please enter 1 for encryption and 2 for decryption"),
		read(Type),
		writeln("Please enter the key:"),
		read(Key),
		Type = 1 ->
			writeln("Please enter message:"),
			read(Message),
			encrypt(Message, Key, Result),
			write("Result: "),
			writeln(Result);
		Type = 2 ->
			writeln("Please enter code:"),
			read(Message),
			decrypt(Message, Key, Result),
			write("Result: "),
			writeln(Result);
		
			writeln("Invalid code"),!,fail.
		
