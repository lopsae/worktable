

class LoremIpsum {

	static let LOREM = "Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla facilisi. Nam liber tempor cum soluta nobis eleifend option congue nihil imperdiet doming id quod mazim placerat facer possim assum. Typi non habent claritatem insitam; est usus legentis in iis qui facit eorum claritatem. Investigationes demonstraverunt lectores legere me lius quod ii legunt saepius. Claritas est etiam processus dynamicus, qui sequitur mutationem consuetudium lectorum. Mirum est notare quam littera gothica, quam nunc putamus parum claram, anteposuerit litterarum formas humanitatis per seacula quarta decima et quinta decima. Eodem modo typi, qui nunc nobis videntur parum clari, fiant sollemnes in futurum."
	static var splitLorem: [String]?


	static func string(_ words: Int) -> String {
		if splitLorem == nil {
			splitLorem = LOREM.components(separatedBy: " ")
		}

		if words <= 0 {
			return ""
		}

		var substringIndex = LOREM.startIndex
		var wordIndex = 0
		while wordIndex < words {
			let wordLength = splitLorem![wordIndex].characters.count
			substringIndex = LOREM.index(substringIndex, offsetBy: wordLength + 1)
			wordIndex += 1
		}

		// Remove the last space
		substringIndex = LOREM.index(before: substringIndex)

		return String(LOREM[LOREM.startIndex ... substringIndex])
	}

}
