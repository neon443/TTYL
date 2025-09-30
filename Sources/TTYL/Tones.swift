//
//  Tones.swift
//  TTYL
//
//  Created by neon443 on 30/09/2025.
//

enum NumberTones {
	static func tone(number: Int, x: Double) -> Double {
		return HighTone.0.freq.wave(x: x) + LowTone.0.freq.wave(x: x)
	}
}

enum HighTone: Int {
	case `0` = 1209
	case `1` = 1336
	case `2` = 1477
	case `3` = 1633
	
	var freq: Frequency {
		return Frequency(rawValue: self.rawValue)
	}
}

enum LowTone: Int {
	case `0` = 697
	case `1` = 770
	case `2` = 852
	case `3` = 941
	
	var freq: Frequency {
		return Frequency(rawValue: self.rawValue)
	}
}
