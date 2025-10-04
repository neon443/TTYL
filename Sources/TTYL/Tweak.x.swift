import Foundation
import Orion
import TTYLC
import UIKit
import AudioToolbox
import Darwin

class TelephonyHook: ClassHook<NSObject> {
	static var targetName: String { "CXCallUpdate" }
	static var subclassMode: SubclassMode = .createSubclassNamed("CXCallUpdate")
	
	func getCallCapabilitiesUpdateForCall(_ arg2: CInt, _ arg3: CInt) -> CInt {
		let ret = orig.getCallCapabilitiesUpdateForCall(arg2, arg3)
		NSLog("TTYL: Telephony")
		return ret
	}
}
