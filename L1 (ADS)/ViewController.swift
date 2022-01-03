//
//  ViewController.swift
//  L1 (ADS)
//
//  Created by Yuriy Nefedov on 28.09.2021.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var titleLabel: NSTextField!
    @IBOutlet weak var selectionTime: NSTextField!
    @IBOutlet weak var insertionTime: NSTextField!
    @IBOutlet weak var mergeTime: NSTextField!
    @IBOutlet weak var shellTime: NSTextField!
    var timeLabels: [NSTextField]?
    
    @IBOutlet weak var selectionProgressBar: NSProgressIndicator!
    @IBOutlet weak var insertionProgressBar: NSProgressIndicator!
    @IBOutlet weak var mergeProgressBar: NSProgressIndicator!
    @IBOutlet weak var shellProgressBar: NSProgressIndicator!
    var progressBars: [NSProgressIndicator]?
    
    @IBOutlet weak var selectionComparisons: NSTextField!
    @IBOutlet weak var insertionComparisons: NSTextField!
    @IBOutlet weak var mergeComparisons: NSTextField!
    @IBOutlet weak var shellComparisons: NSTextField!
    var comparisonLabels: [NSTextField]?
    
    @IBOutlet weak var selectionComparisonsBar: NSProgressIndicator!
    @IBOutlet weak var insertionComparisonsBar: NSProgressIndicator!
    @IBOutlet weak var mergeComparisonsBar: NSProgressIndicator!
    @IBOutlet weak var shellComparisonsBar: NSProgressIndicator!
    var comparisonBars: [NSProgressIndicator]?
    
    @IBOutlet weak var arrayTypePopUpButton: NSPopUpButton!
    @IBOutlet weak var arraySizePopUpButton: NSPopUpButton!
    @IBOutlet weak var startButton: NSButton!
    
    
    var testArray: [Int] = []
    let observer: Observer = Observer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupManualOutlets()
        setupSelectableLabels()
        
        var testArray = Array<Int>.randomizedIntArray(ofSize: 5)
        testArray.shellSort()
        print(testArray)
        
    }
    
    override func viewDidAppear() {
        self.view.window?.title = "Efficiency of sorting algorithms"
        self.view.window?.styleMask.remove(.resizable)

    }
    
    private func setupManualOutlets() {
        timeLabels = [selectionTime, insertionTime, mergeTime, shellTime]
        progressBars = [selectionProgressBar, insertionProgressBar, mergeProgressBar, shellProgressBar]
        comparisonLabels = [selectionComparisons, insertionComparisons, mergeComparisons, shellComparisons]
        comparisonBars = [selectionComparisonsBar, insertionComparisonsBar, mergeComparisonsBar, shellComparisonsBar]
    }
    
    private func setupSelectableLabels() {
        for label in comparisonLabels! {
            label.isSelectable = true
        }
        for label in timeLabels! {
            label.isSelectable = true
        }
    }
    
    private func fillTestArray(withElementsFromRange range: ClosedRange<Int>, numberOfElements n: Int) {
        testArray = []
        for _ in 1...n {
            testArray.append(Int.random(in: range))
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func startButtonPressed(_ sender: NSButton) {
        resetResults()
        updateTitleFromCurrentSelection()
        let array = generateArrayFromCurrentSelection()
        var results = observer.conductExperiment(usingArray: array)
        results[.selectionSort] = [0.0, 0]
        DispatchQueue.main.async {
            self.updateDisplayedResults(with: results)
        }
    }
    
    @IBAction func clearButtonPressed(_ sender: NSButton) {
        resetResults()
    }
    
    
    private func resetResults() {
        DispatchQueue.main.async {
            for label in self.timeLabels! {
                label.displayTime(valueInSeconds: 0.0)
            }
            for label in self.comparisonLabels! {
                label.stringValue = "0"
            }
            
            for bar in self.progressBars! {
                bar.doubleValue = 0.0
            }
            for bar in self.comparisonBars! {
                bar.doubleValue = 0.0
            }
        }
    }
    
    private func generateArrayFromCurrentSelection() -> [Int] {
        let sizeComponents = arraySizePopUpButton.title.components(separatedBy: "^")
        let baseSelected = Double(sizeComponents[0])!
        let powerSelected = Double(sizeComponents[1])!
        let trueArraySize = Int(pow(baseSelected, powerSelected))
                
        switch arrayTypePopUpButton.title {
        case "randomized":
            return Array<Int>.randomizedIntArray(ofSize: trueArraySize)
        case "ascending":
            return Array<Int>.randomizedAscendingIntArray(ofSize: trueArraySize)
        case "descending":
            return Array<Int>.randomizedDescendingIntArray(ofSize: trueArraySize)
        case "1-2-3":
            return Array<Int>.randomized123Array(ofSize: trueArraySize)
        default:
            fatalError("Could not parse specified array type")
        }
        
        
    }
    
    private func updateTitleFromCurrentSelection() {
        let arrayType = arrayTypePopUpButton.selectedItem?.title
        let arraySize = arraySizePopUpButton.selectedItem?.title
        
        titleLabel.stringValue = "Sorting \(arrayType == "ascending" ? "an" : "a") \(arrayType!) array of \(arraySize!) elements"
    }
    
    private func updateDisplayedResults(with newResults: [SortingAlgorithm: [Any]]) {
        
        let selectionTime = newResults[.selectionSort]![0] as! Double
        let insertionTime = newResults[.insertionSort]![0] as! Double
        let mergeTime = newResults[.mergeSort]![0] as! Double
        let shellTime = newResults[.shellSort]![0] as! Double
        
        let selectionComparisons = newResults[.selectionSort]![1] as! Int
        let insertionComparisons = newResults[.insertionSort]![1] as! Int
        let mergeComparisons = newResults[.mergeSort]![1] as! Int
        let shellComparisons = newResults[.shellSort]![1] as! Int
        
        updateTimeResults(with: [selectionTime, insertionTime, mergeTime, shellTime])
        updateComparisonResults(with: [selectionComparisons, insertionComparisons, mergeComparisons, shellComparisons])
    }
    
    private func updateTimeResults(with newResults: [Double]) {
        selectionTime.displayTime(valueInSeconds: newResults[0])
        insertionTime.displayTime(valueInSeconds: newResults[1])
        mergeTime.displayTime(valueInSeconds: newResults[2])
        shellTime.displayTime(valueInSeconds: newResults[3])
        
        let maxTime = newResults.max()!
        
        selectionProgressBar.doubleValue = calculateRelativeProgress(forTime: newResults[0], withMaxValueOf: maxTime)
        insertionProgressBar.doubleValue = calculateRelativeProgress(forTime: newResults[1], withMaxValueOf: maxTime)
        mergeProgressBar.doubleValue = calculateRelativeProgress(forTime: newResults[2], withMaxValueOf: maxTime)
        shellProgressBar.doubleValue = calculateRelativeProgress(forTime: newResults[3], withMaxValueOf: maxTime)
    }
    
    private func updateComparisonResults(with newResults: [Int]) {
        selectionComparisons.stringValue = String(newResults[0])
        insertionComparisons.stringValue = String(newResults[1])
        mergeComparisons.stringValue = String(newResults[2])
        shellComparisons.stringValue = String(newResults[3])
        
        let maxComparisons = newResults.max()!
        
        selectionComparisonsBar.doubleValue = calculateRelativeProgress(forTime: Double(newResults[0]), withMaxValueOf: Double(maxComparisons))
        insertionComparisonsBar.doubleValue = calculateRelativeProgress(forTime: Double(newResults[1]), withMaxValueOf: Double(maxComparisons))
        mergeComparisonsBar.doubleValue = calculateRelativeProgress(forTime: Double(newResults[2]), withMaxValueOf: Double(maxComparisons))
        shellComparisonsBar.doubleValue = calculateRelativeProgress(forTime: Double(newResults[3]), withMaxValueOf: Double(maxComparisons))
    }
    
    private func calculateRelativeProgress(forTime time: Double, withMaxValueOf maxValue: Double) -> Double {
        return 100.0 * time / maxValue
    }
}

