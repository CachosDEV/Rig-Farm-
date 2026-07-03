-- ============================================
-- AUTO ROLL & AUTO BUY - NEXUSUI COMPLETE
-- Usando Toggle, MultiDropdown e Main Tab
-- ============================================

-- ─── Carregar NexusUI ────────────────────────
local NexusUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoAlip/NexusUI/refs/heads/main/NexusUI.lua"))()

-- ─── Verificar se já está rodando ────────────
if getgenv().AutoRollRunning then
    return print("⚠️ Auto Roll já está rodando!")
end
getgenv().AutoRollRunning = true

-- ─── Carregar Bibliotecas ────────────────────
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- ═══════════════════════════════════════════════
-- 📦 DADOS DO JOGO
-- ═══════════════════════════════════════════════

-- ─── 12 RARIDADES ──────────────────────────────
local RARITY_ORDER = {
    "Common", "Uncommon", "Rare", "Epic", "Legendary",
    "Secret", "Prismatic", "Divine", "Exotic", "Transcended",
    "Celestial", "Eternal"
}

-- ─── SEMENTES COMPLETAS ────────────────────────
local Seeds = {
    -- COMMON
    {name = "Carrot", rarity = "Common", cost = 100, chance = "Common"},
    {name = "Beetroot", rarity = "Common", cost = 250, chance = "Common"},
    {name = "Pumpkin", rarity = "Common", cost = 500, chance = "Common"},
    {name = "Cinnamon", rarity = "Common", cost = nil, chance = "?"},
    -- UNCOMMON
    {name = "Wheat", rarity = "Uncommon", cost = 600, chance = "Uncommon"},
    {name = "Melon", rarity = "Uncommon", cost = 1200, chance = "Uncommon"},
    {name = "Onion", rarity = "Uncommon", cost = 2500, chance = "Uncommon"},
    {name = "Cantaloupe", rarity = "Uncommon", cost = 3500, chance = "Uncommon"},
    {name = "Watermelon", rarity = "Uncommon", cost = 5000, chance = "Uncommon"},
    -- RARE
    {name = "Blueberry", rarity = "Rare", cost = 15000, chance = "Rare"},
    {name = "Cabbage", rarity = "Rare", cost = 40000, chance = "Rare"},
    {name = "Grape", rarity = "Rare", cost = 65000, chance = "Rare"},
    {name = "Peach", rarity = "Rare", cost = 120000, chance = "Rare"},
    {name = "Bamboo", rarity = "Rare", cost = 90000, chance = "Rare"},
    -- EPIC
    {name = "Corn", rarity = "Epic", cost = 200000, chance = "Epic"},
    {name = "Plum", rarity = "Epic", cost = 300000, chance = "Epic"},
    {name = "Cauliflower", rarity = "Epic", cost = 500000, chance = "Epic"},
    {name = "Nectarine", rarity = "Epic", cost = 600000, chance = "Epic"},
    {name = "Sunflower", rarity = "Epic", cost = 650000, chance = "Epic"},
    {name = "Citrus", rarity = "Epic", cost = 850000, chance = "Epic"},
    -- LEGENDARY
    {name = "Spring Onion", rarity = "Legendary", cost = 2500000, chance = "Legendary"},
    {name = "Mango", rarity = "Legendary", cost = 4000000, chance = "Legendary"},
    {name = "Mushroom", rarity = "Legendary", cost = 7000000, chance = "Legendary"},
    {name = "Banana", rarity = "Legendary", cost = 9000000, chance = "Legendary"},
    {name = "Potato", rarity = "Legendary", cost = 15000000, chance = "Legendary"},
    -- SECRET
    {name = "Strawberry", rarity = "Secret", cost = 30000000, chance = "Secret"},
    {name = "Glowshroom", rarity = "Secret", cost = 45000000, chance = "Secret"},
    {name = "Beanstalk", rarity = "Secret", cost = 55000000, chance = "Secret"},
    {name = "Tomato", rarity = "Secret", cost = 100000000, chance = "Secret"},
    -- PRISMATIC
    {name = "Apple", rarity = "Prismatic", cost = 500000000, chance = "Prismatic"},
    {name = "Cherry Blossom", rarity = "Prismatic", cost = 1500000000, chance = "Prismatic"},
    {name = "Blood Orange", rarity = "Prismatic", cost = 1200000000, chance = "Prismatic"},
    {name = "Garlic", rarity = "Prismatic", cost = 5500000000, chance = "Prismatic"},
    {name = "Iron Fern", rarity = "Prismatic", cost = 4000000000, chance = "Prismatic"},
    -- DIVINE
    {name = "Golden Apple", rarity = "Divine", cost = 5000000000, chance = "Divine"},
    {name = "Cocoa", rarity = "Divine", cost = 10000000000, chance = "Divine"},
    {name = "Crystalberry", rarity = "Divine", cost = 20000000000, chance = "Divine"},
    {name = "Diamond Blossom", rarity = "Divine", cost = 2500000000, chance = "Seed Collector"},
    {name = "Horned Melon", rarity = "Divine", cost = 3500000000, chance = "Trucker"},
    -- EXOTIC
    {name = "Moonflower", rarity = "Exotic", cost = 70000000000, chance = "Exotic"},
    {name = "Passionfruit", rarity = "Exotic", cost = 100000000000, chance = "Exotic"},
    {name = "Pepper", rarity = "Exotic", cost = 900000000000, chance = "Exotic"},
    {name = "Void Fruit", rarity = "Exotic", cost = 15000000000000, chance = "Exotic"},
    {name = "Dragonfruit", rarity = "Exotic", cost = 8000000000, chance = "Seed Pack"},
    -- TRANSCENDED
    {name = "Durian", rarity = "Transcended", cost = 100000000000000, chance = "Transcended"},
    {name = "Ghost Pepper", rarity = "Transcended", cost = 275000000000000, chance = "Transcended"},
    {name = "Papaya", rarity = "Transcended", cost = 150000000000000, chance = "Transcended"},
    {name = "Ember Fruit", rarity = "Transcended", cost = 350000000000000, chance = "Transcended"},
    {name = "Aurora Lotus", rarity = "Transcended", cost = 750000000000000, chance = "Transcended"},
    -- CELESTIAL
    {name = "Celestial Rose", rarity = "Celestial", cost = 1000000000000000, chance = "Celestial"},
    {name = "Starlight Bloom", rarity = "Celestial", cost = 2000000000000000, chance = "Celestial"},
    {name = "Nova Petal", rarity = "Celestial", cost = 3500000000000000, chance = "Celestial"},
    -- ETERNAL
    {name = "Eternal Flame", rarity = "Eternal", cost = 10000000000000000, chance = "Eternal"},
    {name = "Immortal Root", rarity = "Eternal", cost = 20000000000000000, chance = "Eternal"},
    {name = "Timeless Blossom", rarity = "Eternal", cost = 50000000000000000, chance = "Eternal"},
}

local SeedByName = {}
for _, s in ipairs(Seeds) do SeedByName[s.name] = s end

-- ─── SEMENTES QUE NÃO PODEM SER ROLADAS ───────
local NOT_FROM_ROLL = {
    ["Not rollable"] = true, ["Friend-o-Tron"] = true,
    ["Trucker Event"] = true, ["Alien Event"] = true,
    ["Seed Pack"] = true, ["Admin"] = true,
    ["?"] = true, ["Seed Collector"] = true,
    ["Trucker"] = true, ["Composter"] = true,
}

-- ─── Filtrar sementes roláveis ─────────────────
local rollableSeeds = {}
for _, seed in ipairs(Seeds) do
    if not NOT_FROM_ROLL[seed.chance] then
        table.insert(rollableSeeds, seed.name)
    end
end

-- ═══════════════════════════════════════════════
-- 🎮 REMOTES E ESTADO
-- ═══════════════════════════════════════════════

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RollSeeds = Remotes:WaitForChild("RollSeeds")
local BuySeed = Remotes:WaitForChild("BuySeed")

local autoRollEnabled = false
local autoBuyEnabled = false
local buyLock = false
local autoBuyList = {}

-- ═══════════════════════════════════════════════
-- 💾 SALVAR CONFIGURAÇÕES
-- ═══════════════════════════════════════════════

local SETTINGS_FILE = "AutoRoll_Settings.json"
local HttpService = game:GetService("HttpService")

local function saveSettings()
    local data = {
        autoRoll = autoRollEnabled,
        autoBuy = autoBuyEnabled,
        buyList = {},
    }
    for name in pairs(autoBuyList) do
        table.insert(data.buyList, name)
    end
    pcall(writefile, SETTINGS_FILE, HttpService:JSONEncode(data))
end

local function loadSettings()
    local ok, raw = pcall(readfile, SETTINGS_FILE)
    if not ok or not raw or raw == "" then return end
    local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then return end

    if data.autoRoll then autoRollEnabled = true end
    if data.autoBuy then autoBuyEnabled = true end

    if type(data.buyList) == "table" then
        for _, name in ipairs(data.buyList) do
            autoBuyList[name] = true
        end
    end
end

-- ═══════════════════════════════════════════════
-- 🎨 CRIAR WINDOW NEXUSUI
-- ═══════════════════════════════════════════════

local Window = NexusUI:CreateWindow({
    Name = "🌱 Auto Farm",
    Version = "2.0",
    Author = "By Player",
    Size = UDim2.new(0, 500, 0, 400),
})

-- ─── TAB MAIN ────────────────────────────────────
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://10723415903" -- Ícone de info
})

-- ─── SEÇÃO: CONTROLES ───────────────────────────
local ControlsSection = MainTab:CreateSection({
    Name = "🎮 Controles"
})

-- 🔄 Toggle: Auto Spin
local AutoSpinToggle = ControlsSection:CreateToggle({
    Name = "🔄 Auto Spin",
    Description = "Gira automaticamente a cada 1 segundo",
    Default = false,
    Callback = function(value)
        autoRollEnabled = value
        saveSettings()
        print("[Auto Roll] " .. (value and "✅ Ativado" or "❌ Desativado"))
    end
})

-- 💰 Toggle: Auto Buy
local AutoBuyToggle = ControlsSection:CreateToggle({
    Name = "💰 Auto Buy",
    Description = "Compra automaticamente as sementes selecionadas",
    Default = false,
    Callback = function(value)
        autoBuyEnabled = value
        saveSettings()
        print("[Auto Buy] " .. (value and "✅ Ativado" or "❌ Desativado"))
    end
})

-- ─── SEÇÃO: SELEÇÃO DE SEMENTES ──────────────────
local SeedsSection = MainTab:CreateSection({
    Name = "🌱 Selecionar Sementes"
})

-- 📋 MultiDropdown: Selecionar sementes
local SeedMultiDropdown = SeedsSection:CreateMultiDropdown({
    Name = "🌾 Sementes para Comprar",
    Description = "Selecione as sementes que serão compradas automaticamente",
    Options = rollableSeeds,
    Defaults = {},
    Callback = function(selectedList)
        -- Limpa a lista atual
        table.clear(autoBuyList)
        
        -- Adiciona as sementes selecionadas
        for _, seedName in ipairs(selectedList) do
            autoBuyList[seedName] = true
        end
        
        saveSettings()
        print("[Seleção] " .. #selectedList .. " sementes selecionadas")
    end
})

-- ─── SEÇÃO: STATUS ───────────────────────────────
local StatusSection = MainTab:CreateSection({
    Name = "📊 Status"
})

-- Label para mostrar status
local StatusLabel = StatusSection:CreateLabel({
    Name = "⏳ Status: Aguardando...",
    Description = "Mostra o estado atual do script"
})

-- Função para atualizar status
local function UpdateStatus(text)
    StatusLabel:Set(text)
end

-- ─── SEÇÃO: INFORMAÇÕES ──────────────────────────
local InfoSection = MainTab:CreateSection({
    Name = "ℹ️ Informações"
})

InfoSection:CreateLabel({
    Name = "📌 Total de Sementes",
    Description = #rollableSeeds .. " sementes disponíveis para seleção"
})

InfoSection:CreateLabel({
    Name = "🔄 Intervalo de Roll",
    Description = "1 segundo entre cada giro"
})

InfoSection:CreateLabel({
    Name = "🔗 GitHub",
    Description = "https://github.com/LeoAlip/NexusUI"
})

-- ═══════════════════════════════════════════════
-- 🔄 LÓGICA PRINCIPAL
-- ═══════════════════════════════════════════════

-- ─── Carregar Settings ───────────────────────────
loadSettings()

-- Aplicar estado carregado aos toggles
if autoRollEnabled then
    AutoSpinToggle:Set(true)
end
if autoBuyEnabled then
    AutoBuyToggle:Set(true)
end

-- Aplicar sementes selecionadas ao MultiDropdown
local loadedSeeds = {}
for name in pairs(autoBuyList) do
    table.insert(loadedSeeds, name)
end
if #loadedSeeds > 0 then
    SeedMultiDropdown:Set(loadedSeeds)
end

-- Atualizar status inicial
UpdateStatus("⏳ Status: " .. (autoRollEnabled and "🔄 Girando" or "💤 Aguardando"))

-- ─── Auto Roll Loop ──────────────────────────────
local ROLL_INTERVAL = 1
local lastRoll = 0

RunService.Heartbeat:Connect(function()
    if not autoRollEnabled or buyLock then return end
    local now = tick()
    if now - lastRoll >= ROLL_INTERVAL then
        lastRoll = now
        RollSeeds:FireServer()
        UpdateStatus("⏳ Status: 🔄 Girando...")
    end
end)

-- ─── Auto Buy ─────────────────────────────────────
RollSeeds.OnClientEvent:Connect(function(rolledSeeds)
    if not autoBuyEnabled or buyLock then return end
    if type(rolledSeeds) ~= "table" then return end

    local queue = {}
    for slotIndex, seedName in ipairs(rolledSeeds) do
        if type(seedName) == "string" and autoBuyList[seedName] then
            table.insert(queue, {slot = slotIndex, name = seedName})
        end
    end

    if #queue == 0 then 
        UpdateStatus("⏳ Status: 💤 Nenhuma semente selecionada")
        return 
    end

    buyLock = true
    UpdateStatus("⏳ Status: 🛒 Comprando sementes...")
    
    task.spawn(function()
        for i, entry in ipairs(queue) do
            BuySeed:FireServer(entry.slot)
            UpdateStatus("⏳ Status: 🛒 Comprou " .. entry.name .. " (" .. i .. "/" .. #queue .. ")")
            task.wait(0.8)
        end
        buyLock = false
        UpdateStatus(autoRollEnabled and "⏳ Status: 🔄 Girando" or "⏳ Status: 💤 Aguardando")
    end)
end)

-- ─── Atualizar Status quando toggles mudam ──────
-- (Já feito nos callbacks dos toggles)

print("✅ Auto Farm NexusUI carregado com sucesso!")
print("📊 " .. #rollableSeeds .. " sementes disponíveis")
print("🎯 " .. #loadedSeeds .. " sementes selecionadas")
