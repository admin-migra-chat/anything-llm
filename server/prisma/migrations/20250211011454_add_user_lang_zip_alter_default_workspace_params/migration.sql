-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_workspaces" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "slug" TEXT NOT NULL,
    "vectorTag" TEXT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "openAiTemp" REAL,
    "openAiHistory" INTEGER NOT NULL DEFAULT 20,
    "lastUpdatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "openAiPrompt" TEXT,
    "similarityThreshold" REAL DEFAULT 0.75,
    "chatProvider" TEXT,
    "chatModel" TEXT,
    "topN" INTEGER DEFAULT 6,
    "chatMode" TEXT DEFAULT 'query',
    "pfpFilename" TEXT,
    "agentProvider" TEXT,
    "agentModel" TEXT,
    "queryRefusalResponse" TEXT,
    "vectorSearchMode" TEXT DEFAULT 'default'
);
INSERT INTO "new_workspaces" ("agentModel", "agentProvider", "chatMode", "chatModel", "chatProvider", "createdAt", "id", "lastUpdatedAt", "name", "openAiHistory", "openAiPrompt", "openAiTemp", "pfpFilename", "queryRefusalResponse", "similarityThreshold", "slug", "topN", "vectorSearchMode", "vectorTag") SELECT "agentModel", "agentProvider", "chatMode", "chatModel", "chatProvider", "createdAt", "id", "lastUpdatedAt", "name", "openAiHistory", "openAiPrompt", "openAiTemp", "pfpFilename", "queryRefusalResponse", "similarityThreshold", "slug", "topN", "vectorSearchMode", "vectorTag" FROM "workspaces";
DROP TABLE "workspaces";
ALTER TABLE "new_workspaces" RENAME TO "workspaces";
CREATE UNIQUE INDEX "workspaces_slug_key" ON "workspaces"("slug");
CREATE TABLE "new_users" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "username" TEXT,
    "password" TEXT NOT NULL,
    "userLang" TEXT NOT NULL DEFAULT 'en',
    "zipCode" TEXT,
    "pfpFilename" TEXT,
    "role" TEXT NOT NULL DEFAULT 'default',
    "suspended" INTEGER NOT NULL DEFAULT 0,
    "seen_recovery_codes" BOOLEAN DEFAULT true,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastUpdatedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "dailyMessageLimit" INTEGER
);
INSERT INTO "new_users" ("createdAt", "dailyMessageLimit", "id", "lastUpdatedAt", "password", "pfpFilename", "role", "seen_recovery_codes", "suspended", "username") SELECT "createdAt", "dailyMessageLimit", "id", "lastUpdatedAt", "password", "pfpFilename", "role", "seen_recovery_codes", "suspended", "username" FROM "users";
DROP TABLE "users";
ALTER TABLE "new_users" RENAME TO "users";
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
