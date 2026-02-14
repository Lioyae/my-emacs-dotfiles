;;; early-init.el --- Windows 11 性能与 UI 预优化 -*- lexical-binding: t -*-

;; 1. 提升启动时的垃圾回收阈值，减少 Windows 上的卡顿
(setq gc-cons-threshold most-positive-fixnum
      gc-cons-percentage 0.6)

;; 2. 提前禁用 UI 元素，防止启动后窗口“闪烁”
(push '(menu-bar-lines . 0) default-frame-alist)
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars . nil) default-frame-alist)

;; 3. 针对 Windows 的文件路径优化：暂时禁用文件名处理
(setq file-name-handler-alist nil)

;; 4. 禁用包管理器早期加载（由 init.el 接管）
(setq package-enable-at-startup nil)

;; 5. 抑制原生编译警告 (Windows 下常弹出)
(setq native-comp-async-report-warnings-errors 'silent)
