//
//  AulaView.swift
//  Leitura-de-presenca
//
//  Created by Mohamad Lobo on 19/07/24.
//

import SwiftUI
import VisionKit

struct AulaView: View {
    @State var isShowingScanner = true
    @State private var scannedText = ""
    @State private var classes: [StudentClassModel] = []
        
    func getListStudents() {
        list_classes(token: "token 72676edc7e28b924083c19cc4c8ee2ebf983604f") { [self]res in
            classes = res
        }
    }
    
    var body: some View {
        VStack {
//            if DataScannerViewController.isSupported && DataScannerViewController.isAvailable {
//                ZStack(alignment: .bottom) {
//                    DataScannerRepresentable(
//                        shouldStartScanning: $isShowingScanner,
//                        scannedText: $scannedText,
//                        dataToScanFor: [.barcode(symbologies: [.qr])]
//                    )
//                    
//                    Text(scannedText)
//                        .padding()
//                        .background(Color.white)
//                        .foregroundColor(.black)
//                }
//            } else if !DataScannerViewController.isSupported {
//                Text("It looks like this device doesn't support the Camera")
//            } else {
//                Text("It appears your camera may not be available")
//            }
            Text("Suas aulas")
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
                .frame(height: 50)
            ScrollView {
                VStack() {
                    ForEach(classes, id: \.self) { cl in
                        ClassCard(className: cl.title, classTime: cl.time, hasPresence: cl.hasPresence)
                            .frame(height: 64)
                        Spacer()
                            .frame(height: 16)
                    }
                }
            }
            Button (action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("Ler presença")
                    .fontWeight(.semibold)
            })
            .foregroundColor(.feso)
            .padding(.vertical, 10)
            .padding(.horizontal)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.feso, lineWidth: 2)
            }
            
        }
        .onAppear {
            getListStudents()
        }
        .padding()
    }
}

#Preview {
    AulaView()
}
