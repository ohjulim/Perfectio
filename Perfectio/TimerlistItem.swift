//
//  TimerlistItem.swift
//  Perfectio
//
//  Created by Lim Oh Ju on 12/28/16.
//  Copyright © 2016 ohju. All rights reserved.
//

import Foundation

class TimerlistItem {
	//	var name = ""
	var time = 1000
	//	var checked = false
	var isActive = false
	func toggleActive() {
		isActive = !isActive
	}
}
