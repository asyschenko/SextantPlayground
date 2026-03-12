//
//  JSONTextViewModel.swift
//  JSONPath
//
//  Created by Alex Syschenko on 18.04.2025.
//


import SwiftUI
import Sextant
import Hitch
import Combine

final class JSONTextViewModel: ObservableObject {
    
    private var jsonObject: Any?
    
    @Published var pathString: String = "" {
        didSet {
            processText()
        }
    }
    @Published var leftText: String = "" {
        didSet {
            createJSONObject()
            processText()
        }
    }
    @Published var rightText: String = ""
    @Published var errorStr: String = ""
}

private extension JSONTextViewModel {
    
    func createJSONObject() {
        guard let JSONString = leftText.data(using: .utf8),
              !JSONString.isEmpty else {
            clearError()
            return
        }

        do {
            jsonObject = try JSONSerialization.jsonObject(with: JSONString)
            clearError()
        } catch {
            jsonObject = nil
            show(error)
        }
    }
    
    func processText() {
        guard let jsonObject = jsonObject,
              let resultObject = Sextant.shared.query(jsonObject, values: Hitch(string: pathString)) else {
            rightText = ""
            return
        }

        do {
            let jsonData = try JSONSerialization.data(withJSONObject: resultObject,
                                                      options: [.prettyPrinted])
            rightText = String(data: jsonData,
                               encoding: .utf8) ?? ""
            clearError()
        } catch {
            show(error)
        }
    }
    
    func show(_ error: Error) {
        errorStr = "Error: \(error.localizedDescription)"
    }
    
    func clearError() {
        if !errorStr.isEmpty {
            errorStr.removeAll()
        }
    }
}
