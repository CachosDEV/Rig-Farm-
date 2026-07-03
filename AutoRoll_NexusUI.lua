-- ============================================
-- ╔═══════════════════════════════════════════╗
-- ║     AUTO ROLL & AUTO BUY - NEXUSUI      ║
-- ║        Versão Completa 2.0              ║
-- ╚═══════════════════════════════════════════╝
-- ============================================

-- ─── PARTE 1: CARREGAR BIBLIOTECAS ──────────

local NexusUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/LeoAlip/NexusUI/refs/heads/main/NexusUI.lua"))()

if getgenv().AutoRollRunning then
    return print("⚠️ Auto Roll já está rodando!")
end
getgenv().AutoRollRunning = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

print("🌱 Carregando Auto Farm...")

-- ═══════════════════════════════════════════════
-- PARTE 2: DADOS DO JOGO (SEMENTES COMPLETAS)
-- ═══════════════════════════════════════════════

local RARITY_ORDER = {
    "Common", "Uncommon", "Rare", "Epic", "Legendary",
    "Secret", "Prismatic", "Divine", "Exotic", "Transcended",
    "Celestial", "Eternal"
}

local Seeds = {
    -- ─── COMMON ──────────────────────────────
    {name = "Carrot", rarity = "Common", cost = 100, chance = "Common"},
    {name = "Beetroot", rarity = "Common", cost = 250, chance = "Common"},
    {name = "Pumpkin", rarity = "Common", cost = 500, chance = "Common"},
    {name = "Cinnamon", rarity = "Common", cost = nil, chance = "?"},
    
    -- ─── UNCOMMON ────────────────────────────
    {name = "Wheat", rarity = "Uncommon", cost = 600, chance = "Uncommon"},
    {name = "Melon", rarity = "Uncommon", cost = 1200, chance = "Uncommon"},
    {name = "Onion", rarity = "Uncommon", cost = 2500, chance = "Uncommon"},
    {name = "Cantaloupe", rarity = "Uncommon", cost = 3500, chance = "Uncommon"},
    {name = "Watermelon", rarity = "Uncommon", cost = 5000, chance = "Uncommon"},
    
    -- ─── RARE ────────────────────────────────
    {name = "Blueberry", rarity = "Rare", cost = 15000, chance = "Rare"},
    {name = "Cabbage", rarity = "Rare", cost = 40000, chance = "Rare"},
    {name = "Grape", rarity = "Rare", cost = 65000, chance = "Rare"},
    {name = "Peach", rarity = "Rare", cost = 120000, chance = "Rare"},
    {name = "Bamboo", rarity = "Rare", cost = 90000, chance = "Rare"},
    
    -- ─── EPIC ────────────────────────────────
    {name = "Corn", rarity = "Epic", cost = 200000, chance = "Epic"},
    {name = "Plum", rarity = "Epic", cost = 300000, chance = "Epic"},
    {name = "Cauliflower", rarity = "Epic", cost = 500000, chance = "Epic"},
    {name = "Nectarine", rarity = "Epic", cost = 600000, chance = "Epic"},
    {name = "Sunflower", rarity = "Epic", cost = 650000, chance = "Epic"},
    {name = "Citrus", rarity = "Epic", cost = 850000, chance = "Epic"},
    
    -- ─── LEGENDARY ────────────────────────────
    {name = "Spring Onion", rarity = "Legendary", cost = 2500000, chance = "Legendary"},
    {name = "Mango", rarity = "Legendary", cost = 4000000, chance = "Legendary"},
    {name = "Mushroom", rarity = "Legendary", cost = 7000000, chance = "Legendary"},
    {name = "Banana", rarity = "Legendary", cost = 9000000, chance = "Legendary"},
    {name = "Potato", rarity = "Legendary", cost = 15000000, chance = "Legendary"},
    
    -- ─── SECRET ──────────────────────────────
    {name = "Strawberry", rarity = "Secret", cost = 30000000, chance = "Secret"},
    {name = "Glowshroom", rarity = "Secret", cost = 45000000, chance = "Secret"},
    {name = "Beanstalk", rarity = "Secret", cost = 55000000, chance = "Secret"},
    {name = "Tomato", rarity = "Secret", cost = 100000000, chance = "Secret"},
    
    -- ─── PRISMATIC ────────────────────────────
    {name = "Apple", rarity = "Prismatic", cost = 500000000, chance = "Prismatic"},
    {name = "Cherry Blossom", rarity = "Prismatic", cost = 1500000000, chance = "Prismatic"},
    {name = "Blood Orange", rarity = "Prismatic", cost = 1200000000, chance = "Prismatic"},
    {name = "Garlic", rarity = "Prismatic", cost = 5500000000, chance = "Prismatic"},
    {name = "Iron Fern", rarity = "Prismatic", cost = 4000000000, chance = "Prismatic"},
    
    -- ─── DIVINE ──────────────────────────────
    {name = "Golden Apple", rarity = "Divine", cost = 5000000000, chance = "Divine"},
    {name = "Cocoa", rarity = "Divine", cost = 10000000000, chance = "Divine"},
    {name = "Crystalberry", rarity = "Divine", cost = 20000000000, chance = "Divine"},
    {name = "Diamond Blossom", rarity = "Divine", cost = 2500000000, chance = "Seed Collector"},
    {name = "Horned Melon", rarity = "Divine", cost = 3500000000, chance = "Trucker"},
    
    -- ─── EXOTIC ──────────────────────────────
    {name = "Moonflower", rarity = "Exotic", cost = 70000000000, chance = "Exotic"},
    {name = "Passionfruit", rarity = "Exotic", cost = 100000000000, chance = "Exotic"},
    {name = "Pepper", rarity = "Exotic", cost = 900000000000, chance = "Exotic"},
    {name = "Void Fruit", rarity = "Exotic", cost = 15000000000000, chance = "Exotic"},
    {name = "Dragonfruit", rarity = "Exotic", cost = 8000000000, chance = "Seed Pack"},
    
    -- ─── TRANSCENDED ──────────────────────────
    {name = "Durian", rarity = "Transcended", cost = 100000000000000, chance = "Transcended"},
    {name = "Ghost Pepper", rarity = "Transcended", cost = 275000000000000, chance = "Transcended"},
    {name = "Papaya", rarity = "Transcended", cost = 150000000000000, chance = "Transcended"},
    {name = "Ember Fruit", rarity = "Transcended", cost = 350000000000000, chance = "Transcended"},
    {name = "Aurora Lotus", rarity = "Transcended", cost = 750000000000000, chance = "Transcended"},
    
    -- ─── CELESTIAL ────────────────────────────
    {name = "Celestial Rose", rarity = "Celestial", cost = 1000000000000000, chance = "Celestial"},
    {name = "Starlight Bloom", rarity = "Celestial", cost = 2000000000000000, chance = "Celestial"},
    {name = "Nova Petal", rarity = "Celestial", cost = 3500000000000000, chance = "Celestial"},
    
    -- ─── ETERNAL ──────────────────────────────
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

-- ─── FILTRAR SEMENTES ROLÁVEIS ────────────────
local rollableSeeds = {}
for _, seed in ipairs(Seeds) do
    if not NOT_FROM_ROLL[seed.chance] then
        table.insert(rollableSeeds, seed.name)
    end
end

print("📊 " .. #rollableSeeds .. " sementes disponíveis para seleção")

-- ═══════════════════════════════════════════════
-- PARTE 3: REMOTES E ESTADO
-- ═══════════════════════════════════════════════

local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local RollSeeds = Remotes:WaitForChild("RollSeeds")
local BuySeed = Remotes:WaitForChild("BuySeed")

local autoRollEnabled = false
local autoBuyEnabled = false
local buyLock = false
local autoBuyList = {}
local isBuying = false

-- ═══════════════════════════════════════════════
-- PARTE 4: SALVAR CONFIGURAÇÕES
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
    local success, err = pcall(writefile, SETTINGS_FILE, HttpService:JSONEncode(data))
    if success then
        print("💾 Configurações salvas!")
    else
        print("❌ Erro ao salvar: " .. tostring(err))
    end
end

local function loadSettings()
    local ok, raw = pcall(readfile, SETTINGS_FILE)
    if not ok or not raw or raw == "" then 
        print("📂 Nenhum arquivo de configuração encontrado")
        return 
    end
    
    local ok2, data = pcall(function() return HttpService:JSONDecode(raw) end)
    if not ok2 or type(data) ~= "table" then 
        print("❌ Erro ao ler configurações")
        return 
    end

    if data.autoRoll then autoRollEnabled = true end
    if data.autoBuy then autoBuyEnabled = true end

    if type(data.buyList) == "table" then
        for _, name in ipairs(data.buyList) do
            autoBuyList[name] = true
        end
        print("📂 Carregadas " .. #data.buyList .. " sementes selecionadas")
    end
    print("✅ Configurações carregadas!")
end

-- ═══════════════════════════════════════════════
-- PARTE 5: CRIAÇÃO DA INTERFACE NEXUSUI
-- ═══════════════════════════════════════════════

print("🎨 Criando interface...")

local Window = NexusUI:CreateWindow({
    Name = "🌱 Auto Farm",
    Version = "2.0",
    Author = "By Player",
    Size = UDim2.new(0, 550, 0, 450),
})

-- ─── TAB MAIN ────────────────────────────────────
local MainTab = Window:CreateTab({
    Name = "Main",
    Icon = "rbxassetid://10723415903"
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
        UpdateStatus()
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
        UpdateStatus()
        print("[Auto Buy] " .. (value and "✅ Ativado" or "❌ Desativado"))
    end
})

-- ─── SEÇÃO: SELEÇÃO DE SEMENTES ──────────────────
local SeedsSection = MainTab:CreateSection({
    Name = "🌱 Selecionar Sementes"
})

-- 📋 MultiDropdown com tamanho maior
local SeedMultiDropdown = SeedsSection:CreateMultiDropdown({
    Name = "🌾 Sementes para Comprar",
    Description = "Selecione as sementes que serão compradas automaticamente",
    Options = rollableSeeds,
    Defaults = {},
    Callback = function(selectedList)
        table.clear(autoBuyList)
        for _, seedName in ipairs(selectedList) do
            autoBuyList[seedName] = true
        end
        saveSettings()
        UpdateStatus()
        print("[Seleção] " .. #selectedList .. " sementes selecionadas")
    end
})

-- ─── SEÇÃO: STATUS ───────────────────────────────
local StatusSection = MainTab:CreateSection({
    Name = "📊 Status"
})

-- Label de Status
local StatusLabel = StatusSection:CreateLabel({
    Name = "⏳ Status: Aguardando...",
    Description = "Mostra o estado atual do script"
})

-- Label de Sementes Selecionadas
local SelectedCountLabel = StatusSection:CreateLabel({
    Name = "🌱 Sementes Selecionadas: 0",
    Description = "Quantas sementes estão marcadas para compra"
})

-- Função para atualizar status
local function UpdateStatus()
    local status = "💤 Aguardando"
    if autoRollEnabled and autoBuyEnabled then
        status = "🔄 Girando e Comprando"
    elseif autoRollEnabled then
        status = "🔄 Girando"
    elseif autoBuyEnabled then
        status = "💰 Comprando"
    end
    
    if buyLock or isBuying then
        status = "🛒 Comprando sementes..."
    end
    
    StatusLabel:Set("⏳ Status: " .. status)
    
    -- Atualiza contador de sementes
    local count = 0
    for _ in pairs(autoBuyList) do count = count + 1 end
    SelectedCountLabel:Set("🌱 Sementes Selecionadas: " .. count)
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
    Name = "📦 Raridades Disponíveis",
    Description = table.concat(RARITY_ORDER, ", ")
})

InfoSection:CreateLabel({
    Name = "🔗 NexusUI GitHub",
    Description = "https://github.com/LeoAlip/NexusUI"
})

print("✅ Interface criada com sucesso!")

-- ═══════════════════════════════════════════════
-- PARTE 6: CARREGAR CONFIGURAÇÕES
-- ═══════════════════════════════════════════════

loadSettings()

-- Aplicar estado carregado
if autoRollEnabled then
    AutoSpinToggle:Set(true)
end
if autoBuyEnabled then
    AutoBuyToggle:Set(true)
end

-- Aplicar sementes selecionadas
local loadedSeeds = {}
for name in pairs(autoBuyList) do
    table.insert(loadedSeeds, name)
end
if #loadedSeeds > 0 then
    SeedMultiDropdown:Set(loadedSeeds)
end

UpdateStatus()

-- ═══════════════════════════════════════════════
-- PARTE 7: LÓGICA PRINCIPAL (AUTO ROLL)
-- ═══════════════════════════════════════════════

local ROLL_INTERVAL = 1
local lastRoll = 0

RunService.Heartbeat:Connect(function()
    if not autoRollEnabled or buyLock or isBuying then 
        return 
    end
    
    local now = tick()
    if now - lastRoll >= ROLL_INTERVAL then
        lastRoll = now
        local success, err = pcall(function()
            RollSeeds:FireServer()
        end)
        
        if not success then
            print("❌ Erro ao girar: " .. tostring(err))
        end
    end
end)

-- ═══════════════════════════════════════════════
-- PARTE 8: LÓGICA PRINCIPAL (AUTO BUY)
-- ═══════════════════════════════════════════════

RollSeeds.OnClientEvent:Connect(function(rolledSeeds)
    if not autoBuyEnabled or buyLock or isBuying then 
        return 
    end
    
    if type(rolledSeeds) ~= "table" then 
        print("⚠️ Dados inválidos recebidos do RollSeeds")
        return 
    end

    -- Verifica se tem sementes selecionadas
    local hasSelected = false
    for _ in pairs(autoBuyList) do
        hasSelected = true
        break
    end
    
    if not hasSelected then
        return
    end

    -- Fila de compras
    local queue = {}
    for slotIndex, seedName in ipairs(rolledSeeds) do
        if type(seedName) == "string" and autoBuyList[seedName] then
            table.insert(queue, {slot = slotIndex, name = seedName})
        end
    end

    if #queue == 0 then 
        return 
    end

    print("🛒 " .. #queue .. " sementes para comprar")
    buyLock = true
    isBuying = true
    UpdateStatus()
    
    task.spawn(function()
        for i, entry in ipairs(queue) do
            local success, err = pcall(function()
                BuySeed:FireServer(entry.slot)
            end)
            
            if success then
                print("✅ Comprou: " .. entry.name .. " (" .. i .. "/" .. #queue .. ")")
            else
                print("❌ Erro ao comprar " .. entry.name .. ": " .. tostring(err))
            end
            
            task.wait(0.5) -- Delay entre compras
        end
        
        buyLock = false
        isBuying = false
        UpdateStatus()
        print("✅ Todas as compras finalizadas!")
    end)
end)

-- ═══════════════════════════════════════════════
-- PARTE 9: COMANDOS DO EXECUTOR
-- ═══════════════════════════════════════════════

-- Comandos para usar no executor
_G.AutoFarm = {
    ToggleSpin = function()
        AutoSpinToggle:Set(not autoRollEnabled)
    end,
    ToggleBuy = function()
        AutoBuyToggle:Set(not autoBuyEnabled)
    end,
    GetStatus = function()
        return {
            autoRoll = autoRollEnabled,
            autoBuy = autoBuyEnabled,
            selectedSeeds = autoBuyList,
            isBuying = isBuying
        }
    end,
    SelectSeeds = function(seedList)
        if type(seedList) ~= "table" then
            print("❌ Use uma tabela com os nomes das sementes")
            return
        end
        SeedMultiDropdown:Set(seedList)
    end
}

print("═" .. string.rep("═", 48))
print("🌱 Auto Farm carregado com sucesso!")
print("📊 " .. #rollableSeeds .. " sementes disponíveis")
print("🎯 " .. #loadedSeeds .. " sementes selecionadas")
print("═" .. string.rep("═", 48))
print("📌 Comandos disponíveis:")
print("  _G.AutoFarm.ToggleSpin()  - Liga/Desliga Auto Spin")
print("  _G.AutoFarm.ToggleBuy()   - Liga/Desliga Auto Buy")
print("  _G.AutoFarm.GetStatus()   - Mostra status atual")
print("  _G.AutoFarm.SelectSeeds() - Seleciona sementes")
print("═" .. string.rep("═", 48))
