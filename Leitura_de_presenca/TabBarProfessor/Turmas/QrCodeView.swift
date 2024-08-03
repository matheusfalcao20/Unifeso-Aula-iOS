//
//  QrCodeView.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct QrCodeView: View {
    //MARK: - PROPERTY
    
    var qrCodeString : String
    @Environment(\.dismiss) var dismiss
    
    
    //MARK: - FUNCTIONS
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")
        
        if let outputImage = filter.outputImage {
            let context = CIContext()
            let cgImage = context.createCGImage(outputImage, from: outputImage.extent)
            
            return UIImage(cgImage: cgImage!)
        }
        
        return nil
    }
    
    
    //MARK: - BODY
    var body: some View {
        VStack(alignment: .center){
            HStack {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundStyle(.colorTextField)
                        .padding(.leading)
                }
                Spacer()
            }
            Text("Qr Code de presença")
                .font(.largeTitle)
                .fontWeight(.medium)
                .padding(.top)
            
            Spacer()
            
            if let qrCodeImage = generateQRCode(from: qrCodeString) {
                Image(uiImage: qrCodeImage)
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            } else {
                Text("Invalid QR Code")
            }
            
            Spacer()
        }
    }
}


//MARK: - PREVIEW
#Preview {
    QrCodeView(qrCodeString: "d82wnwu")
}
