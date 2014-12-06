vowels = {"a","e","i","o","u","y"}
consonants = {"B","C","D","F","G","H","J","K","L","M","N","P","R","S","T","V","W","Z"}
syllables = {}

function makeMagic()
	math.randomseed(os.time())
	local num = 0
	while num < 107 do
		local cons = math.random(1,#consonants)
		local vowel = math.random(1,#vowels)
		local combo = consonants[cons] ..vowels[vowel]
		local same = 0
		if #syllables > 0 then
			for j = 1,#syllables do
				if combo == syllables[j] then
					same = 1
				end
			end
			if same == 0 then
				table.insert(syllables,combo)
				num = num + 1
			end
		else
			table.insert(syllables,combo)
		end
	end
	for k = 1,#spells do
		while spells[k].words == "" do
			local word = makeWord()
			local same = 0
			for l = 1,#spells do
				if spells[l].words == word then
					same = 1
				end
			end
			if same == 0 then
				spells[k].words = word
			end
		end
	end
end

function makeWord()
	local num = math.random(3,5)
	local word = ""
	for i = 1,num do
		local syl = math.random(1,#syllables)
		word = word ..syllables[syl]
	end
	return word
end
