;;; init.el --- 完整集成配置 -*- lexical-binding: t -*-

;; ==========================================
;; 1. 基础编码与环境 (修复 void-function 错误)
;; ==========================================
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8)

;; ==========================================
;; 2. 插件管理器初始化 (MELPA)
;; ==========================================
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("gnu"   . "https://elpa.gnu.org/packages/")
                         ("nongnu". "https://elpa.nongnu.org/nongnu/")))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

;; 确保安装必要的插件
(dolist (pkg '(doom-themes doom-modeline no-littering))
  (unless (package-installed-p pkg)
    (package-install pkg)))

;; ==========================================
;; 3. 字体设置 (JetBrains Mono Nerd Font)
;; ==========================================
(defun my/setup-fonts ()
  (condition-case nil
      (set-face-attribute 'default nil 
                          :family "JetBrains Mono" 
                          :height 125 
                          :weight 'normal)
    (error (message "字体加载失败，请确认为所有用户安装了 JetBrains Mono"))))

(if (daemonp)
    (add-hook 'server-after-make-frame-hook #'my/setup-fonts)
  (my/setup-fonts))

;; ==========================================
;; 4. 界面与编辑器基础设置
;; ==========================================
;; 相对行号
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode t)

;; Tab 缩进 = 2 空格
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq-default c-basic-offset 2) ; 针对 STM32 的 C 代码

;; 自动补全括号
(electric-pair-mode 1)

;; 基础视觉
(setq inhibit-startup-screen t)
(global-hl-line-mode 1)
(delete-selection-mode 1)

;; ==========================================
;; 5. 主题美化与状态栏
;; ==========================================
(require 'doom-themes)
(load-theme 'doom-one t) ; 推荐 doom-one 或 doom-nord
(doom-themes-visual-bell-config)

(require 'doom-modeline)
(doom-modeline-mode 1)
;; 注意：首次使用请执行 M-x nerd-icons-install-fonts

;; ==========================================
;; 6. 文件夹乱搞治理 (No-Littering)
;; ==========================================
(require 'no-littering)
;; 将自动生成的备份文件统一管理，不散落在项目目录
(setq backup-directory-alist
      `((".*" . ,(no-littering-expand-var-file-name "backup/"))))
(setq auto-save-file-name-transforms
      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))
(setq create-lockfiles nil) ; 禁用 .# 文件

;; ==========================================
;; 7. 启动后性能恢复
;; ==========================================
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024) ; 恢复到 16MB
                  gc-cons-percentage 0.1)
            (setq file-name-handler-alist default-file-name-handler-alist)))

;; 快速打开配置文件快捷键 (F5)
(global-set-key (kbd "<f5>") (lambda () (interactive) (find-file user-init-file)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
