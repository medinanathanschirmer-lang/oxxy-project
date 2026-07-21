#!/system/bin/sh

TOTAL=8
STEP=0
PKG="com.exemplo.jogo"   # <- troque pelo pacote do jogo/app alvo

if [ "$(id -u 2>/dev/null)" = "0" ]; then ROOT=1; else ROOT=0; fi
MANUFACTURER=$(getprop ro.product.manufacturer)
IS_SAMSUNG=0
echo "$MANUFACTURER" | grep -qi samsung && IS_SAMSUNG=1

barra() {
  atual=$1; total=$2; largura=20
  preenchido=$((atual * largura / total))
  vazio=$((largura - preenchido))
  bar=""; i=0
  while [ $i -lt $preenchido ]; do bar="${bar}#"; i=$((i+1)); done
  i=0
  while [ $i -lt $vazio ]; do bar="${bar}-"; i=$((i+1)); done
  pct=$((atual * 100 / total))
  printf "\r[%s] %d%%" "$bar" "$pct"; echo ""
}

echo "===================================="
echo "   OXXYZ - ADB Optimizer"
[ $ROOT -eq 1 ] && echo "   Modo: ROOT" || echo "   Modo: SEM ROOT"
[ $IS_SAMSUNG -eq 1 ] && echo "   Dispositivo: Samsung detectado" || echo "   Dispositivo: nao-Samsung"
echo "===================================="
echo ""

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Otimizando RAM..."
am kill-all
[ $ROOT -eq 1 ] && echo 3 > /proc/sys/vm/drop_caches 2>/dev/null
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Forcando Idle (1 min, sensing/locating imediatos) e congelando $PKG..."
dumpsys battery unplug
dumpsys deviceidle force-idle
settings put global device_idle_constants "inactive_to=60000,sensing_to=0,locating_to=0,motion_inactive_to=60000,idle_after_inactive_to=60000,idle_pending_to=60000,max_idle_pending_to=60000,idle_to=60000,max_idle_to=60000,min_time_to_alarm=60000,light_after_inactive_to=60000,light_pre_idle_to=60000,light_idle_to=60000,light_max_idle_to=60000"
am set-standby-bucket "$PKG" restricted
settings put global app_standby_enabled 1
settings put global job_scheduler_constants "min_ready_jobs_count=0"
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Otimizando CPU..."
if [ $ROOT -eq 1 ]; then
  for gov in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
    echo performance > "$gov" 2>/dev/null
  done
else
  echo "Sem root: ajuste de governor nao disponivel, pulando"
fi
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Otimizando rede (Wi-Fi/dados)..."
settings put global wifi_idle_ms 0
settings put global wifi_sleep_policy 2
cmd wifi set-power-save-enabled disabled
settings put global mobile_data_always_on 0
settings put global wifi_aggressive_handover 1
cmd wifi set-scan-throttling-enabled disabled
settings put global wifi_scan_always_enabled 0
cmd wifi set-low-latency-mode enabled
settings put global wifi_watchdog_on 0
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Ajustando gerenciamento de processos..."
device_config put activity_manager use_freezer true
settings put global activity_manager_constants max_cached_processes=16
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Forcando Vulkan (via ANGLE) para $PKG e systemui..."
settings put global angle_gl_driver_all_apps 1
settings put global angle_gl_driver_selection_pkgs "$PKG,com.android.systemui"
settings put global angle_gl_driver_selection_values "angle,angle"
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Otimizando GPU (System Graphics Driver)..."
settings put global game_driver_all_apps 2
settings put global updatable_driver_all_apps 2
setprop debug.hwui.renderer skiavk
if [ $IS_SAMSUNG -eq 1 ]; then
  echo ">> Aplicando flags Samsung (nao-oficiais, testadas pela comunidade)"
  settings put global sem_enhanced_cpu_responsiveness 1
  settings put global GPUTUNER_SWITCH true
fi
barra $STEP $TOTAL

STEP=$((STEP+1))
echo "[$STEP/$TOTAL] Ativando Game Mode Performance para $PKG..."
cmd game mode performance "$PKG"
barra $STEP $TOTAL

echo ""
echo "===================================="
echo "   Concluido!"
echo "===================================="