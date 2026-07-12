# Design System — Bistro Bellini

## Product Context
- **What this is:** Bistro Bellini — 正式意大利餐厅单页网站，基于 La Maison 模板定制
- **Who it's for:** 寻求精致意大利正餐体验的食客
- **Space/industry:** 高端餐饮 / Fine Dining
- **Project type:** 营销网站（单页、多区段）

## Brand Memory
> 地中海的光线与食材 — 明亮自然、食材为本。让人记住橄榄油的光泽、手工意面的纹理、地中海阳光的通透感。

## Aesthetic Direction
- **Direction:** 奢华/精致（Luxury/Refined）— 托斯卡纳庄园的克制优雅
- **Decoration level:** intentional — 亚麻布质感、石材肌理、橄榄木色调
- **Mood:** 安静、温暖、精致。不是红白格子桌布的「意大利」，而是石墙农舍、橄榄树影、手工意面的安静奢华

## Typography

| 角色 | 字体 | 字重 | 用途 |
|------|------|------|------|
| Hero 标题 | Playfair Display | 700 | 餐厅名称、Hero 大标题 |
| 区段标题 | Cormorant Garamond | 600 | 各区段 h2 标题 |
| 正文 | Source Serif 4 | 400, 500 | 段落、菜单描述、表单标签 |
| 引用/斜体 | Cormorant Garamond | 400 italic | 主厨引言、装饰性文字 |
| 小标签 | Source Serif 4 | 400 | eyebrow、按钮、导航链接 |

**加载方式:** Google Fonts CDN
```
Playfair Display: ital,wght@0,700;1,700
Cormorant Garamond: ital,wght@0,600;1,400;1,600
Source Serif 4: opsz,wght@8..60,400;8..60,500
```

## Color

**Approach:** restrained — 1 个主 accent + 温暖中性色系

### CSS 令牌

| 令牌 | 色值 | 角色 |
|------|------|------|
| `--olive` | `#1D241A` | 深色底（Hero 背景、Footer、Nav 滚动） |
| `--olive-90` | `rgba(29, 36, 26, 0.92)` | 半透明深色底（Nav 毛玻璃） |
| `--olive-60` | `rgba(29, 36, 26, 0.60)` | 低透明度深色 |
| `--olive-40` | `rgba(29, 36, 26, 0.40)` | 更低透明度深色 |
| `--stone` | `#F7F4EE` | 主背景（石灰白） |
| `--stone-80` | `rgba(247, 244, 238, 0.80)` | 半透明背景 |
| `--sage` | `#6B7D52` | 主 accent（交互色、eyebrow、hover、链接） |
| `--sage-15` | `rgba(107, 125, 82, 0.15)` | accent 发光/背景 |
| `--gold` | `#C4A44A` | 次 accent（点缀金、scroll indicator、引用边框） |
| `--gold-20` | `rgba(196, 164, 74, 0.20)` | 金色半透明 |
| `--warm-charcoal` | `#3A3832` | 正文色 |
| `--light-warm` | `#E6E0D4` | 深色底上的浅文字 |
| `--border-warm` | `#D2CCC0` | 边框、分割线 |
| `--white` | `#FFFDF7` | 卡片白（菜单区、表单背景） |

### 对比度验证

| 组合 | 比例 | WCAG |
|------|------|------|
| `--warm-charcoal` on `--stone` | ~8.5:1 | AAA |
| `--sage` on `--stone` | ~4.6:1 | AA |
| `--light-warm` on `--olive` | ~10:1 | AAA |
| `--gold` on `--olive` | ~6:1 | AA |
| `--sage` on `--white` | ~4.8:1 | AA |

## Spacing
- **Base unit:** 4px
- **Density:** spacious（高端餐饮需要呼吸感）
- **区段 padding:** 120px 桌面 / 80px 移动
- **网格 gap:** 64px（双列）/ 48px（菜单）
- **Max content width:** 1040px

## Layout
- **Approach:** hybrid — 编辑式 Hero/Gallery + 网格规整的菜单/预订
- **Gallery:** 不等宽 Masonry（CSS columns），保留图片原始比例
- **导航:** 固定顶部，Hero 区透明 → 滚动后实色+毛玻璃
- **Story/Private:** 双列图文（桌面）/ 单列堆叠（移动，图在上）
- **Menu:** 双列菜单网格（桌面）/ 单列（移动）

## Border Radius
- **默认:** 2px（克制、精致）
- **按钮/输入框:** 2px
- **不使用大圆角** — 保持锐利、建筑感

## Motion
- **Approach:** intentional
- **入场:** IntersectionObserver 驱动的 reveal（opacity + translateY），0.8s cubic-bezier(0.25, 0.46, 0.45, 0.94)
- **Hero:** 视差背景 + 文字入场动画（1.2-1.4s）
- **Hover:** 图片微缩放(1.03-1.04x)、颜色过渡(0.3-0.6s)
- **菜单 hover:** 左侧 accent 条展开 + 暖光阴影（"点蜡烛"动效）
- **Reduced motion:** 尊重系统偏好，降级为纯淡入

## Photography
- **风格:** 明调地中海风 — 自然光、浅色背景、强调食材本色和手工质感
- **饱和度:** 自然，不人工增强
- **主题:** 手工意面细节、橄榄油光泽、餐厅内景（石墙、烛光）、地中海食材
- **来源:** Unsplash（占位）→ 客户提供实拍照片

## Decisions Log
| Date | Decision | Rationale |
|------|----------|-----------|
| 2026-07-12 | 初始设计系统创建 | /design-consultation 基于 La Maison 模板定制，经 /plan-design-review 评审确认 |
| 2026-07-12 | 配色 → Olive & Stone | 脱离法式深棕+琥珀，转向托斯卡纳橄榄灰+鼠尾草绿 |
| 2026-07-12 | 字体 → 全衬线方案 | Playfair Display + Cormorant Garamond + Source Serif 4，替换 Inter |
| 2026-07-12 | Gallery → Masonry | 不等宽网格替代 4 列正方形，增强叙事感 |
| 2026-07-12 | 预订 → 内联确认 | 表单提交后替换为确认卡片，不跳转 |
| 2026-07-12 | 照片 → 明调地中海风 | 自然光+食材本色，匹配「地中海的光线与食材」品牌记忆点 |
