//
//  NotificationManager.swift
//  LocalNotifications
//
//  Created by Enzo Henrique Botelho Romão on 09/10/25.
//

import Foundation
import UserNotifications
import Combine

class NotificationManager: ObservableObject {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    @Published var authorizationStatus: UNAuthorizationStatus = .notDetermined
    
    func requestAuthorization() async {
        let settings = await notificationCenter.notificationSettings() // Pega as configurações do notificationCenter
        authorizationStatus = settings.authorizationStatus
        
        guard !(authorizationStatus == .authorized) || !(authorizationStatus == .provisional) else {
            return print("✅ O status de autorização já permite o envio de notificações: \(authorizationStatus)")
        }
        
        guard !(authorizationStatus == .denied) else {
            return print("❌ O status de autorização está 'Negado'. Necessário ativar nas configurações do dispositivo")
        }
        
        do {
            /* Envia a requisição de autorização para as opções de:
             .badge - Atualizar contador de notificações no ícone do app
             .alert - Mostra um banner ou alerta visual na tela
             .sound - Reproduz o som configurado na notificação
            */
            try await notificationCenter.requestAuthorization(options: [.badge, .alert, .sound])
            print("Solicitação de autorização enviada com sucesso!")
        } catch {
            print("Não foi possível fazer a solicitação de autorização...")
        }
    }
    
    func scheduleNotification(title: String, body: String) async {
        // Só continua caso o status de autorização seja autorizado ou provisional ()
        guard (authorizationStatus == .authorized) || (authorizationStatus == .provisional) else {
            return print("O status de autorização não permite o envio de notificações...")
        }
        
        let notificationContent = UNMutableNotificationContent() // Objeto de conteúdo mutável que permite configuração das propriedades dentro do app
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // Trigger que vai ser disparado quando a condição ser atingida (timeInterval)
        
        let requestId = UUID().uuidString // Request da notificação só aceita String como identifier
        let request = UNNotificationRequest(identifier: requestId, content: notificationContent, trigger: trigger)
        
        do {
            try await notificationCenter.add(request)
            print("Request adicionado com sucesso!")
        } catch {
            print("Não foi possível adicionar o request da notificação ao sistema...")
        }
    }
}
