//
//  Assistant.swift
//  Resolutionary
//
//  Created by Luke Drushell on 12/11/22.
//

import SwiftUI

struct Assistant: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var resolutions: [String]
    
    let key = API().key
    @State var prompt = ""
    @State var output: [String] = []
    @State private var jsonData = Data()
    
    @State var sending: Bool = false
    @State var returning: Bool = false
    @State var spinning: Bool = false
    
    @State var messageLoading = false
    
    @FocusState var showKeyboard: Bool
    
    @State var pastPrompt = ""
    
    
    @State var promptCopy = ""
    
    
    //Credits
    @State var showPurchase: Bool = false
    @State var credits = UserDefaults.standard.integer(forKey: "credits")
    
    func sendRequest(redo: Bool) {
        var input = "Tell me a joke about dolphins"
        if !redo {
            if promptCopy == "" { promptCopy = "Say: You forgot to ask me a question!" }
            pastPrompt = promptCopy
            input = promptCopy
            promptCopy = ""
        }
        
        let url = URL(string: "https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(key)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let json = ["model": "text-davinci-003", "prompt": "\(redo ? pastPrompt : input)", "temperature" : 0.7, "max_tokens" : 256, "top_p" : 1, "frequency_penalty" : 0, "presence_penalty" : 0] as [String : Any]
        let jsonData = try! JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let decoder = JSONDecoder()
                let decoded = try! decoder.decode(AIResponse.self, from: data)
                let message = decoded.choices?.first?.text ?? "Uh oh, something has gone wrong!"
                withAnimation {
                    messageLoading = false
                    output.append(message.cleanResponse())
                }
            }
        }.resume()
    }
    
    func pickExample() -> String {
        let examples = ["How can I get started on my New Years Resolution: ", "Whats a good way to work on my New Years Resolution of: ", "Whats a fun way to work on this New Years Resolution: "]
        let selected = examples.randomElement() ?? "How can I get started on my New Years Resolution of "
        if resolutions.isEmpty == false {
            let output = selected + resolutions.randomElement()!
            return output
        }
        return "How can I get started on my New Years Resolutions?"
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("This is an AI Chatbot, feel free to ask for tips on how to complete your New Years Resolutions!")
                .font(.caption)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .padding(.bottom, 5)
                .padding(.top, -15)
            Divider()
            VStack {
                VStack(alignment: .leading) {
                    ForEach(output, id: \.self, content: { response in
                        Text(response).padding()
                            .frame(width: UIScreen.main.bounds.width * 0.85)
                            .font(.headline)
                            .background(Color.green.opacity(0.2))
                            .cornerRadius(18)
                            .textSelection(.enabled)
                    })
                }
                if messageLoading {
                    LoadingSymbol()
                }
            } .padding(.bottom, 150)
        }
        .onTapGesture {
            showKeyboard = false
        }
        .overlay(alignment: .bottom, content: {
            HStack {
                if #available(iOS 16.0, *) {
                    TextEditor(text: $prompt)
                        .frame(minWidth: UIScreen.main.bounds.width * 0.8, minHeight: 60, maxHeight: 160)
                        .fixedSize(horizontal: false, vertical: true)
                        .scrollContentBackground(.hidden)
                        .padding(5)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(18)
                        .focused($showKeyboard)
                } else {
                    // Fallback on earlier versions
                    TextEditor(text: $prompt)
                        .frame(minWidth: UIScreen.main.bounds.width * 0.8, minHeight: 60, maxHeight: 160)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(5)
                        .background(Color.green.opacity(0.2))
                        .cornerRadius(18)
                        .focused($showKeyboard)
                }
                VStack {
                    Button {
                        if credits - 1 > 0 {
                            credits -= 1
                            UserDefaults.standard.set(credits, forKey: "credits")
                            withAnimation(.easeIn) {
                                promptCopy = prompt
                                prompt = ""
                                sending = true
                                messageLoading = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                sendRequest(redo: false)
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8, execute: {
                                returning = true
                                sending = false
                            })
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                                withAnimation(.easeOut) {
                                    returning = false
                                }
                            })
                        }
                    } label: {
                        FlyButton(icon: "arrow.up.circle.fill")
                    }
                    .offset(x: returning ? UIScreen.main.bounds.width * 1 : 0, y: sending ? -80 : 0)
                    Button {
                        if credits - 1 > 0 {
                            credits -= 1
                            UserDefaults.standard.set(credits, forKey: "credits")
                            spinning = true
                            sendRequest(redo: true)
                        }
                    } label: {
                        SpinButton(icon: "arrow.counterclockwise.circle.fill", rotating: $spinning)
                    }
                }
            }
            .padding(6)
            .background(.regularMaterial)
            .cornerRadius(22)
            .padding()
        })
        .onAppear(perform: {
            let example = pickExample()
            withAnimation {
                prompt = example
                pastPrompt = example
            }
            if credits == 0 { credits = 2 }
        })
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                Button {
                    showPurchase.toggle()
                } label: {
                    Text("Credits: \(credits - 1)")
                }
            })
        })
        .sheet(isPresented: $showPurchase, content: {
            BuyCredits()
        })
    }
}

struct Assistant_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct AIResponse: Codable {
    let id: String?
    let object: String?
    let created: Int?
    let model: String?
    let prompt: String?
    let response: String?
    let choices: [Choices]?
    let usage: Usage?
}

struct Choices: Codable, Hashable {
    let text: String
    let index: Int
    let logprops: Int?
    let finish_reason: String
}

struct Usage: Codable {
    let prompt_tokens: Int
    let completion_tokens: Int
    let total_tokens: Int
}

extension String {
    func cleanResponse() -> String {
        var input = self
        if input.prefix(2) == "\n\n" {
            input.removeFirst(2)
        }
        let output = input
        return output
    }
}

