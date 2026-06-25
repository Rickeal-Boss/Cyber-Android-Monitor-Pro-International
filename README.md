# Cyber-Android-Monitor-Pro-By-RB Device Performance Monitor System Monitor(deviceinfoviewer\Device Info Viewer)

![Device](1.png)

> **⚠️ Important Notice / License Notice**  
> This project uses the [PolyForm Noncommercial License 1.0.0](https://polyformproject.org/licenses/noncommercial/1.0.0/) license. Please refer to the `LICENSE` file in the project root directory for the full legal text.  
> **Source code is publicly available for personal learning, research, and non-commercial use only**.  
> It is strictly prohibited to package and sell this software, or use it as part of a paid service or SaaS hosting service.  
> It is strictly prohibited to integrate advertisements into derivative works of this software for direct or indirect commercial gain.
> 
> *This project is source-available and free for **personal, educational, and non-commercial use only**. Commercial use is strictly prohibited without a separate license.*

---

## 🏛️ Project

Cyber-Android-Monitor-Pro-By-RB
 System Monitor(deviceinfoviewer) provides real-time, accurate hardware status data visualization. Through an intuitive dark interface, it helps developers, hardware enthusiasts, and everyday users fully understand their device's operational status. Supports Android 5+

## 🗼 Core Features
> A full-featured Android device information monitoring application built on the **MVVM + Koin DI** architecture, using **Jetpack Compose + Material3**.
> Achieves deep hardware detection without ROOT privileges, adapted for domestic ROMs such as Xiaomi HyperOS, OPPO ColorOS, Vivo OriginOS, etc.

---

## 🛞 Core Highlights

### 🔬 Deep Hardware Detection (Multi-level Fallback Strategy)

| Module | Detection Depth | Fallback Layers |
|---------|---------|--------------|
| **CPU Temperature** | HardwarePropertiesManager → sysfs thermal_zone → hwmon/Platform-specific → SensorManager → Battery Temperature | 5 levels |
| **GPU Frequency/Load** | 50+ sysfs paths + Dynamic attributes + Load estimation | 5 layers |
| **Battery Cycle Count** | BatteryManager hidden API → 50+ sysfs paths → dumpsys | 8 levels |
| **Battery Current/Capacity** | Xiaomi BMS → OPPO oplus_chg → 15+ paths | Multi-vendor specific |
| **GPS Satellites** | GNSS Status Callback (API 30+) + Reflection compatibility (API 21-23) | Dual API |

### 🚀🏺 Snapdragon Platform Specific Optimizations
- Scan `thermal_message/` direct temperature files (HyperOS specific)
- Qualcomm `qcom-battery/` battery cycle count path
- CpuCache.lookup() 4-strategy matching (Direct match → Normalized prefix removal → MTK numeric segment → codenameAliases)

### 🎨 Bat-inspired Futuristic Cyberpunk Theme
- Pure purple neon color scheme (NeonPurple/Bright/Pale/Deep)
- Pulse indicator (PulseDot) real-time monitoring indicator
- Matrix digit font + scanline animation
- Edge-to-Edge full-screen design
- Global lighting effect (GlobalLightState): Canvas radial gradient + AGSL RuntimeShader (API 33+), Spring animation follows finger
- Acrylic noise overlay (Win10 Fluent style)
- Pulse indicator (PulseDot) real-time monitoring indicator
- Orbitron font (Bold for titles / Medium for body text, injected globally via MaterialTheme.typography)
---

### 🌐 Internationalization (i18n)
- Supports 3 languages: Simplified Chinese (default) / English / Traditional Chinese
- API 33+: `AppCompatDelegate.setApplicationLocales` for real-time switching
- API <33: `attachBaseContext` wrapContext + manual recreate
- Traditional Chinese auto-converted via OpenCC s2twp
- Language switch requires restart

### 🖥️ Floating Window System 6th Generation
- 9 metrics with independent toggles: CPU / GPU / Battery / Memory / Temperature / Network / GPS / Hz / FPS
- Configurable refresh interval per metric: 9 metrics each independent, stepping at 0.2s / 0.5s / 1s / 2s / 5s / 10s / 30s
- Interval changes take effect instantly, no need to restart the floating window
- Serial collection architecture: postDelayed moved inside collection callback to prevent task accumulation; tickInFlight prevents overlap
- Subscribes to DeviceRepository SharedFlow, eliminating duplicate collection
- Real-time FPS monitoring (Choreographer independently driven, properly released)

## 📱 Feature Modules (9 Major Tabs)
| Tab | Feature |
|-----|------|
| **Overview** | Device core information at a glance, global lighting effect |
| **CPU** | Frequency/Temperature/Usage real-time curves, core cluster grouping |
| **GPU** | Frequency/Load/Temperature, multi-path Fallback detection |
| **Memory** | RAM usage + running memory dimension breakdown |
| **Battery** | Temperature/Current/Voltage/Capacity/SoH/Cycle Count/Charging Protocol Detection/Power Save Mode Detection |
| **Network** | WiFi/Mobile Data speed + Signal strength + Nearby AP signals |
| **GPS** | Satellite sky view (SatelliteSkyView) + Satellite search status + Speed |
| **Sensors** | 10 sensor real-time waveforms (Canvas self-drawn, 80 sample point Bézier smoothing), including XYZ and single-line |
| **Details** | Full device hardware information overview (OEM ROM deep recognition) |

### 🔋 Smart Refresh Strategy (RefreshPolicy)
- Foreground/Background dual mode: Background maintains full-speed data collection, only pauses animation rendering (global lighting Spring animation + pointer events)
- Power save mode detection: System-level `PowerManager.isPowerSaveMode`, automatically caps at 5s when enabled
- When power save mode is on, battery page displays an orange warning card to alert the user
- Per-module configuration: CPU / GPU / Battery / Memory each have independent refresh intervals, adjustable per module in the settings page

### ⚙️ Settings Page (Android 15 Predictive Back)
- Refresh rate: 5 options: 0.5s / 1s / 2s / 3s / 5s
- Per-module configuration: CPU/GPU/Battery/Memory each have independent intervals (Settings → Refresh Rate → Adjust per module individually)
- Refresh strategy (RefreshPolicy):
  - Foreground/Background dual mode, background maintains full-speed data collection, only pauses animation rendering
  - Power save mode automatically caps at 5s (system-level PowerManager.isPowerSaveMode detection)
  - When power save mode is on, battery page displays orange warning card (!)
- Overlay animation enter/exit
- Language switch (Simplified Chinese/English/Traditional Chinese)
- Predictive back gesture (`PredictiveBackHandler`, Android 15+; auto-degrades to traditional back on domestic ROMs that don't support it)

---

## 🖥️ Floating Window System

- **9 metrics selectable**: CPU / GPU / Battery / Memory / Temperature / Network / GPS / Hz / FPS, independently toggleable
- **Configurable refresh interval per metric** (9 metrics each independent):
  - Stepping: 0.2s / 0.5s / 1s / 2s / 5s / 10s / 30s
  - Interval changes take effect instantly, no restart needed
  - Changed to subscribe to DeviceRepository SharedFlow, eliminating duplicate collection
  - Serial collection: postDelayed moved inside data collection callback, preventing task accumulation
  - tickInFlight anti-overlap flag, auto-retry when sysfs is slow
  - Device-specific optimization recovery (CpuCache injection)
- Real-time FPS monitoring (Choreographer independently driven, properly released before onDestroy)
- SharedPreferences persistent configuration (including position memory)
- Foreground service keep-alive (foregroundServiceType = "specialUse")
- Interval changes take effect instantly, no restart needed

---

## 🔒 Privacy & Security (Fully Local Operation)

| Security Item | Status |
|-------|------|
| INTERNET permission | ❌ Removed |
| Network communication | ❌ Zero HTTP calls / Zero WebView / Zero telemetry |
| Data export | ✅ Only via system ShareSheet (user-controlled) |
| allowBackup | ❌ false (prevents cloud backup) |
| All data | ✅ Fully localized |

---

## 🏗️ Technical Architecture

```
┌─────────────────────────────────────────────┐
│  UI Layer (Compose)                        │
│  Screen × 9 + Components + Theme          │
└──────────────────┬──────────────────────────┘
                   │ observe
┌──────────────────▼──────────────────────────┐
│  ViewModel Layer (Koin DI)                 │
│  AppVM + DashboardVM + CpuVM + GpuVM      │
│  + MemoryVM + BatteryVM + NetworkVM       │
│  + GpsVM + SensorsVM + DeviceVM + OemVM  │
│  + SettingsVM + FloatingWindowVM          │
└──────────────────┬──────────────────────────┘
                   │ collect
┌──────────────────▼──────────────────────────┐
│  Repository Layer (Decomposed God Repo)     │
│  DeviceRepository — Global singleton + LiveData   │
│  historyData: Map<String, List>           │
│  RefreshPolicy refresh strategy state machine              │
└──────────────────┬──────────────────────────┘
                   │ read
┌──────────────────▼──────────────────────────┐
│  DataSource Layer (12 total)                  │
│  CpuDS + GpuDS + BatteryDS + MemoryDS    │
│  NetworkDS + GpsDS + SensorsDS + DeviceDS │
│  OemDS + ShellCommandDS + SysFsReader     │
│  + HistoryCache (300-point ring buffer)          │
└─────────────────────────────────────────────┘
```

### Tech Stack
```
compileSdk  = 35  (Locked, Material Design 3 compatibility constraint)
targetSdk   = 35
minSdk     = 21
Kotlin     = 2.1.0
Compose    = BOM 2024.12.01
Koin DI    = 3.5.6
Java       = 17
```
Due to Sdk 36 compatibility issues with older devices, downgraded to 35.

### 🔧 Build Optimizations

- R8 obfuscation rules cleanup: proguard-rules.pro reduced by 37% (-34 redundant keep lines), size reduced from 12 to 8
- Tightened kotlin retention scope: only `kotlin.reflect.`
- Removed deprecated `android.experimental.r8.dex-startup-optimization` (AGP 8.x deprecated)

---

## 🛡️ Exception Protection System

### catch Throwable (OEM ROM Compatibility)

// ✅ Correct: catch Throwable (covers OEM ROM's Error subclasses)
try {
    val result = riskyOperation()
} catch (t: Throwable) {
    Log.w(TAG, "Operation failed", t)
}

// ❌ Wrong: catch Exception (OEM ROM may throw Error subclasses)
try {
    val result = riskyOperation()
} catch (e: Exception) {
    // Cannot catch NoSuchMethodError / NoSuchFieldError
}

---

### Data Source Health Monitoring

• SourceHealth data class tracks 13 data source statuses
• DataSourceHealthBar component displays error count in real-time
• Multi-level fallback chain catches remain silent (expected failure paths)
• Only Repository-level exceptions are logged

---

### 📈 Chart System
- LineChart: Bézier curve smoothing + gradient fill + entrance animation (single Animatable)
- DualLineChart: Dual line chart (Download/Upload comparison), x-coordinate alignment
- SensorLineChart: Canvas self-drawn waveform (80 sample points, tween 200ms)
- `normalizeChartData()` unified in ChartUtils (deduplicated 6 repeated definitions)
- `derivedStateOf` caches high-frequency sampling triggered recomposition
- FloatArray replaces List<Offset>, Path reuse, areaBrush cached
- GraphicsLayer offscreen GPU cache

---

### 🥇🥈🥉🀄 OEM ROM Deep Recognition
| OEM    | System    | Proprietary Attributes (15+) |
|-------|-------|--------------|
| Xiaomi    | HyperOS/MIUI    | miui.ui.version / miui.region / has_real_blur |
| OPPO    | ColorOS    | version.opporom / oplus.display / oplus_chg battery |
| Vivo    | OriginOS    | vivo.os.version / product.solution / hardware.version |
| SoC Manufacturer + Model Recognition |
| Game Mode / High Performance Mode Detection |
| 30+ vendor original attribute detections |

---

### 🔌 Charging Protocol Auto-Recognition

• PD (Power Delivery)
• QC 3.0 (Quick Charge)
• SuperVOOC (OPPO)
• VOOC (OPPO)
• Mi Turbo Charge (Xiaomi)

---

### 📄 Permission Description

| Permission    | Purpose    | Required |
|-------|-------|----|
| ACCESS_FINE_LOCATION |    GPS satellite detection    | Yes |
| ACCESS_BACKGROUND_LOCATION |    Background GPS    | Some devices require |
| SYSTEM_ALERT_WINDOW    |    Floating window |    Yes |
| BLUETOOTH |    Bluetooth info |    No |
| READ_PHONE_STATE |    Details page info |    Yes |

---

### 🏆 Feature Comparison

|  Feature              | My Application   |
|-------------------|------------------|
|  Battery Cycle Count      | ✅ 50+ paths      |
| Feature                | It's something only * can do |
|---------------------|----------------------|
| Battery Cycle Count        | 🫥 8-level Fallback |
| GPU Dynamic Frequency        | 🫥 5-layer Fallback |
| Charging Protocol Recognition        | 🫥 Maybe Maybe  |
| Floating Window FPS          | ✅ Choreographer  |
| OEM ROM Recognition        | ✅ Proud of domestic major vendors       |
| Privacy (Zero Network)      | ✅😎                |
| Cyberpunk Theme        | ✅😎 Far-leading global lighting System       |
| i18n Multi-language         | ✅ 3 languages: machine-translated and not fully polished...         |
| Power Save Mode Detection        | ✅ PowerManager   |
| Per-Module Refresh Configuration      | ✅ 4 modules independent    |

---

### 📚🤯 Academic Validation

Architecture design validated through Sciverse academic paper retrieval: theoretically, academic papers don't lie, right?

---

## 📝 Recent Update

- Floating window v6 architecture upgrade: Subscribes to DeviceRepository SharedFlow, eliminating duplicate collection
- Power save mode integration: PowerManager.isPowerSaveMode detection, orange warning on battery page
- Background strategy improvement: Full-speed data refresh, only pauses animations
- Settings page slider fix: Non-uniform step positions snap correctly
- Current unit unification: Avoids mA/mW/W mixing
- Sensor detail page fix: derivedStateOf cache, resolved chart issues
- Refresh strategy architecture refactoring (RefreshPolicy): Foreground/Background dual mode, power save mode auto-caps at 5s, animations paused in background
- Global lighting effect (GlobalLight + Acrylic noise), cyberpunk visual upgrade
- Battery module depth: SoH weighted calculation, OCV formula correction, cycle count 8-level Fallback
- Sensor detail page (SensorDetailScreen): AnimatedContent switching, Canvas self-drawn waveform
- i18n refactoring: Supports Simplified Chinese/English/Traditional Chinese, removed complex bloat
- Predictive back gesture fix (Android 15+ PredictiveBackHandler)
- Performance optimization: derivedStateOf cache, FloatArray replaces List, Path reuse, GraphicsLayer offscreen cache
- GPU frequency detection Fallback chain expansion (direct sysfs → shell sysfs → dumpsys → load estimation → system properties)
- Memory page added running memory dimension breakdown
- Network page added nearby AP signals
- Details page bottom layer fully refactored, resolved speaker detection issues
- Optimized continuous positioning: Only positioning on Network and GPS pages
- Added hardware-level charging port detection
- Added real-time power calculation based on voltage/current/single-dual cell
- Resolved GPS domestic OEM restrictions causing satellite search not enabled issue
- Added data source health monitoring
- Comprehensive UI refactoring (kept cards+gradient, removed rounded corner status bar)
- Optimized processor temperature detection (multi-path combination)
- Resolved overview page quick access navigation issue
- Resolved chart not moving issue
- Resolved UI misalignment issue
- Added floating window + position memory system
- Added refresh time page
- Comprehensive software refactoring and icon refactoring, removed redundant code
- Converted from previous Java language to Kotlin

---

### AI Evaluation: GLM5.1 Automated Code Review Report
See details (device-info-viewer-review.html)

---

### APP Screenshots
![](2.jpg)
![](3.jpg)
![](4.png)
![](5.png)
![](6.png)
![](7.png)
![](8.png)
![](9.png)
![](10.jpg)
![](11.png)
![](12.jpg)
![](13.jpg)
![](14.jpg)
![](15.jpg)
![](16.jpg)
![](17.jpg)

---

### Models Participating in Review: Global top-tier GLM-5.2 as architecture review model and DeepSeek V4 Pro as primary review model, DeepSeek V4 Flash, GLM-5.1, GLM-5.0 Turbo as behind models
