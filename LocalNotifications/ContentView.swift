//
//  ContentView.swift
//  LocalNotifications
//
//  Created by Enzo Henrique Botelho Romão on 09/10/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var notificationManager = NotificationManager()
    
    var isAuthorized: Bool {
        notificationManager.authorizationStatus == .authorized ||
        notificationManager.authorizationStatus == .provisional
    }
    
    var body: some View {
        VStack(spacing: 40) {
            VStack(spacing: 20) {
                Image(systemName: "bell.badge.fill")
                    .font(.system(size: 32))
                    .foregroundStyle(.tint)
                    .padding(.top, 16)
                
                Text("Teste de Notificações")
                    .font(.title)
            }
            
            VStack(spacing: 20) {
                Button("Pedir permissão") {
                    Task {
                        await notificationManager.requestAuthorization()
                    }
                }
                .disabled(isAuthorized)
                
                Button("Enviar Notificação") {
                    Task {
                        await notificationManager.scheduleNotification(
                            title: "Notificação de teste",
                            body: "Testando uma notificação local enviada pelo app."
                        )
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
