import Orion
import TTYLC
import UIKit

class MyHook: ClassHook<UILabel> {
	func setText(_ text: String) {
		orig.setText("sybau 🥀")
	}
}
