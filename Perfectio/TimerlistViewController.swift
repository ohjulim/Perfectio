//
//  ViewController.swift
//  Perfectio
//
//  Created by Lim Oh Ju on 12/28/16.
//  Copyright © 2016 ohju. All rights reserved.
//

import UIKit

class TimerlistViewController: UITableViewController {
	
	var timer: Timer?
	var latestIndex: Int = 0
	var beforeIndex: Int = 0
	
	var items: [TimerlistItem]
	
	required init?(coder aDecoder: NSCoder) {
		items = [TimerlistItem]()
		
		let row0item = TimerlistItem()
		row0item.time = 2
		row0item.isActive = false
		items.append(row0item)
		
		let row1item = TimerlistItem()
		row1item.time = 3
		row0item.isActive = false
		items.append(row1item)
		
		let row2item = TimerlistItem()
		row2item.time = 1
		row0item.isActive = false
		items.append(row2item)
		
		super.init(coder: aDecoder)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return items.count
	}
	
	override func tableView(_ tableView: UITableView,
	                        cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TimerlistItem", for: indexPath)
		let item = items[indexPath.row]
		configureTime(for: cell, with: item)
		configureActive(for: cell, with: item)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		latestIndexToBefore()
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = items[beforeIndex]
			timer?.invalidate() // 이전에 선택했던 셀의 타이머를 정지.
			item.isActive = false
			configureActive(for: cell, with: item)
			configureTime(for: cell, with: item)
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let cell = tableView.cellForRow(at: indexPath) {
			let item = items[indexPath.row]
			latestIndex = indexPath.row
			if item.isActive { // isActive 값에 따라 타이머를 실행하거나 정지.
				timer?.invalidate()
			} else {
				timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
					item.time -= 1
					self.configureTime(for: cell, with: item)
					print(item.time)
				}
			}
			item.toggleActive()
			configureActive(for: cell, with: item)
			configureTime(for: cell, with: item)
		}
	}
	
	func configureTime(for cell: UITableViewCell, with item: TimerlistItem) {
		let label = cell.viewWithTag(1000) as! UILabel
		label.text = String(item.time)
		markAsFinished(for: label, with: item)
	}
	
	func configureActive(for cell: UITableViewCell, with item: TimerlistItem) {
		if item.isActive {
			cell.accessoryType = .checkmark
		} else {
			cell.accessoryType = .none
		}
	}
	
	func latestIndexToBefore() {
		beforeIndex = latestIndex
	}
	
	func markAsFinished(for label: UILabel, with item: TimerlistItem) {
		if item.time == 0 {
			item.isActive = false
			label.text = "Done"
			timer?.invalidate()
		}
	}
	
	
	
	
	
}
