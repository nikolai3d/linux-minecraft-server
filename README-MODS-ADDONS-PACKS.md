## Addon Example

Dandy's World Addon (has both resource and behavior packs)

https://dandysworldaddons.carrd.co/ 


## Instructions for server installation

Since your addon includes both a **resource pack** and a **behavior pack**, you'll want to register both with your **Bedrock Dedicated Server** so they load properly for your world.

---

Here’s **exactly what to do**:

---

## 📁 Step 1: Folder setup

Make sure your folder structure looks like this inside your **Bedrock server directory**:

```
Bedrock_Server/
├── behavior_packs/
│   └── your_behavior_pack_folder/
├── resource_packs/
│   └── your_resource_pack_folder/
├── worlds/
│   └── your_world_name/
│       ├── world_behavior_packs.json
│       └── world_resource_packs.json
```

📌 Put your unpacked addon folders (not .mcpack files) inside the `behavior_packs` and `resource_packs` folders.

---

## 🧠 Step 2: Create or edit `world_behavior_packs.json`

Inside your world folder (e.g., `worlds/my_custom_world`), create a file called `world_behavior_packs.json` with this content:

```json
[
  {
    "pack_id": "7f71d4e8-4510-444b-917a-75a5a64e594b",
    "version": [0, 1, 0]
  }
]
```

---

## 🎨 Step 3: Create or edit `world_resource_packs.json`

In the **same world folder**, create a file called `world_resource_packs.json`:

```json
[
  {
    "pack_id": "540b7aee-c245-4129-a06d-6b2b0fa17054",
    "version": [0, 1, 0]
  }
]
```

---

## ⚙️ Optional: Update `server.properties`

In your `server.properties`, you might want to ensure these two lines are set:

```
texturepack-required=false
content-log-file-enabled=true
```

- Set `texturepack-required=true` only if you want **clients to be forced** to accept the pack.
- `content-log-file-enabled=true` will help if you're debugging pack loading issues.

---

## ✅ Step 4: Restart the server

When you start your server, it should now load both packs for the world. If there are issues, check the `logs/` folder or `content_log.txt` for error messages.

