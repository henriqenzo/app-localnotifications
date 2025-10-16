//
//  LocalNotificationsApp.swift
//  LocalNotifications
//
//  Created by Enzo Henrique Botelho Romão on 09/10/25.
//

import SwiftUI
import UserNotifications

@main
struct LocalNotificationsApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate // Adicionando o AppDelegate criado à raiz do projeto
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// Criação de um AppDelegate para gerenciar os comportamentos compartilhados do aplicativo
class AppDelegate: NSObject, UIApplicationDelegate {
    let notificationDelegate = NotificationDelegate() // Instância da classe NotificationDelegate
    
    // Função que avisa o delegate se o processo de inicialização do app já foi concluído
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.delegate = notificationDelegate // Adicionando o notificationDelegate ao notificationCenter
        return true // Retorna true pro app continuar seu processo de execução normalmente
    }
}
