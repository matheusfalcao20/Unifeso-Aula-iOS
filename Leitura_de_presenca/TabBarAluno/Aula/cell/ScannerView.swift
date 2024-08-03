//
//  ScannerView.swift
//  Leitura_de_presenca
//
//  Created by Mohamad Lobo on 01/08/24.
//

import SwiftUI
import AVKit

enum Permission: String {
    case idle = "Not Determined"
    case approved = "Access Granted"
    case denied = "Access Denied"
}

struct ScannerView: View {
    //MARK: - PROPERTY
    
    @State private var isScanning: Bool = false
    @State private var session: AVCaptureSession = .init()
    @State private var cameraPermission: Permission = .idle
    @State private var qrOutput: AVCaptureMetadataOutput = .init()
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    @Environment(\.openURL) private var openURL
    @Environment(\.dismiss) var dismiss
    @State private var isLoading : Bool = false
    @StateObject private var qrDelegate = QRScannerDelegate()
    @State private var scannedCode: String = ""
    @State private var error : String = ""
    @State private var showAlert : Bool = false
    
    //MARK: - FUNCTIONS
    
    func readQrCode() {
//        isLoading = true
        
        var params = [String : Any]()
        params["code"] = scannedCode
        
        StudentAPI.readQrCode(params: params) { response in
            if response.success {
                print(scannedCode)
                if scannedCode != ""{
                    dismiss.callAsFunction()
                }
            } else {
                
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 8){
                Button{
                    dismiss.callAsFunction()
                }label: {
                    Image(systemName: "xmark")
                        .font(.title3)
                        .foregroundColor(.colorTextField)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Coloque o QR code dentro da área")
                    .font(.title3)
                    .foregroundColor(.colorTextField.opacity(0.8))
                    .padding(.top, 20)
                
                Text("A digitalização começará automaticamente")
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer(minLength: 0)
                
                GeometryReader{
                    let size = $0.size
                    ZStack{
                        CameraView(frameSize: CGSize(width: size.width, height: size.width), session: $session)
                        
                            .scaleEffect(0.97)
                        ForEach(0...4, id: \.self){ index in
                            let rotation = Double(index) * 90
                            
                            RoundedRectangle(cornerRadius: 2, style: .circular)
                            
                                .trim(from: 0.61, to: 0.64)
                                .stroke(.black, style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
                                .rotationEffect(.init(degrees: rotation))
                        }
                    }
                    
                    .frame(width: size.width, height: size.width)
                    
                    .overlay(alignment: .top, content: {
                        Rectangle()
                            .fill(.black)
                            .frame(height: 2.5)
                            .shadow(color: .black.opacity(0.8), radius: 8, x: 0, y: isScanning ? 15 : -15)
                            .offset(y: isScanning ? size.width: 0)
                    })
                    
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .padding(.horizontal, 45)
                
                Spacer(minLength: 15)
                Button{
                    if !session.isRunning && cameraPermission == .approved{
                        reactivateCamera()
                        activateScannerAnimation()
                    }
                }label:{
                    Image(systemName: "qrcode.viewfinder")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                }
                
                Spacer(minLength: 45)
            }
            .padding(15)
            .navigationBarBackButtonHidden()
            .onAppear(perform: checkCameraPermisssion)
            .alert(errorMessage, isPresented: $showError){
                if cameraPermission == .denied{
                    Button("Cancel", role: .cancel){
                    }
                }
                
            }
            .onDisappear{
                session.stopRunning()
            }
            .onChange(of: qrDelegate.scannedCode){ newValue in
                if let code = newValue{
                    scannedCode = code
                    
                    session.stopRunning()
                    
                    deActivateScannerAnimation()
                    qrDelegate.scannedCode = nil
                    
                    // Process the scanned code
                    processScannedCode(code)
                }
            }
            if isLoading {
                FALSpinner(isLoading: isLoading)
            }
        }
        .alert("", isPresented: $showAlert) {
            Button("OK"){}
        } message: {
            Text(error)
        }

    }
    
    func reactivateCamera(){
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func activateScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85).delay(0.1).repeatForever(autoreverses: true)){
            isScanning = true
        }
    }
    
    func deActivateScannerAnimation(){
        withAnimation(.easeInOut(duration: 0.85)){
            isScanning = false
        }
    }
    
    func checkCameraPermisssion(){
        Task{
            switch AVCaptureDevice.authorizationStatus(for: .video){
            case .authorized:
                cameraPermission = .approved
                if session.inputs.isEmpty{
                    setupCamera()
                }else{
                    reactivateCamera()
                }
            case .notDetermined:
                if await AVCaptureDevice.requestAccess(for: .video){
                    cameraPermission = .approved
                    setupCamera()
                }else{
                    cameraPermission = .denied
                    presentError("Please provide access to camera for scanning codes")
                }
            case .denied, .restricted:
                cameraPermission = .denied
            default: break
            }
        }
    }
    
    /// Setting up camera
    func setupCamera(){
        do {
            guard let device = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInUltraWideCamera, .builtInWideAngleCamera], mediaType: .video, position: .back).devices.first else {
                presentError("UNKNOWN DEVICE ERROR")
                return
            }
            
            let input = try AVCaptureDeviceInput(device: device)
            
            guard session.canAddInput(input), session.canAddOutput(qrOutput) else {
                presentError("UNKNOWN INPUT/OUTPUT ERROR")
                return
            }
            
            session.beginConfiguration()
            session.addInput(input)
            session.addOutput(qrOutput)
            
            qrOutput.metadataObjectTypes = [.qr]
            qrOutput.setMetadataObjectsDelegate(qrDelegate, queue: .main)
            
            session.commitConfiguration()
            
            DispatchQueue.global(qos: .background).async {
                session.startRunning()
            }
            activateScannerAnimation()
        } catch {
            presentError(error.localizedDescription)
        }
    }
    
    func processScannedCode(_ code: String) {
        // Add any processing logic here. For now, it just dismisses the view.
        print("Scanned Code: \(code)")
        readQrCode()
    }
    
    func presentError(_ message: String){
        errorMessage = message
        showError.toggle()
    }
}

struct ScannerView_Previews: PreviewProvider {
    static var previews: some View {
        ScannerView()
    }
}
