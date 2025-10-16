//
//  NotificationDelegate.swift
//  LocalNotifications
//
//  Created by Enzo Henrique Botelho Romão on 09/10/25.
//

import Foundation
import UserNotifications

// Criação de um NotificationDelegate para processar notificações recebidas
class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    // Método que diz como lidar com uma notificação que chegou enquanto o aplicativo estava executando em foreground (primeiro plano)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        return [.badge, .banner, .sound]
    }
}
