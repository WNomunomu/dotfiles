return {
  "coder/claudecode.nvim",

  -- claudecode.nvim は snacks.nvim をターミナル表示に使う
  -- snacks がなくても動くが、あると floating window 等が使えて快適
  dependencies = { "folke/snacks.nvim" },

  -- プラグインロードのタイミング。
  -- "VeryLazy" にすることで起動速度に影響させない
  event = "VeryLazy",

  opts = {
    -- ============================================================
    -- サーバー設定
    -- ============================================================

    -- Claude CLI がエディタを探すための WebSocket サーバーのポート範囲
    -- 基本デフォルトのままでOK
    port_range = { min = 10000, max = 65535 },

    -- nvim 起動時に自動でサーバーを起動するか
    -- false にすると :ClaudeCode を実行するまでサーバーが立ち上がらない
    auto_start = true,

    -- ログレベル。困ったときは "debug" にすると原因がわかりやすい
    -- "trace" | "debug" | "info" | "warn" | "error"
    log_level = "info",

    -- claude コマンドのパス。グローバル npm インストールなら nil (= "claude") でOK
    -- `claude migrate-installer` を使った場合は "~/.claude/local/claude"
    -- `which claude` の結果を入れる
    terminal_cmd = nil,

    -- ============================================================
    -- 送信・フォーカス挙動
    -- ============================================================

    -- ClaudeCodeSend でテキストを送ったとき、Claude ターミナルを自動でフォーカスするか
    -- true にすると送信後すぐに Claude の返答を見られる
    -- false にすると送信後もエディタ側にカーソルが残る
    focus_after_send = false,

    -- ============================================================
    -- 選択範囲のトラッキング
    -- ============================================================

    -- ビジュアル選択中のテキストをリアルタイムで Claude に伝えるか
    -- true にすると「今選択中のコード」を Claude が常に把握している状態になる
    track_selection = true,

    -- ビジュアルモードを抜けた後、何 ms 後に選択情報をクリアするか
    -- 小さすぎると意図しないタイミングでクリアされる
    visual_demotion_delay_ms = 50,

    -- ============================================================
    -- ターミナル設定
    -- ============================================================
    terminal = {
      -- Claude ターミナルをどちら側に開くか: "left" | "right"
      split_side = "right",

      -- 画面幅に対する Claude ターミナルの横幅の割合
      -- 0.30 = 30%
      split_width_percentage = 0.30,

      -- ターミナルプロバイダー
      -- "auto"   : snacks.nvim があれば snacks、なければ native を使う（推奨）
      -- "snacks" : snacks.nvim を強制使用
      -- "native" : nvim 組み込みのターミナルを使用
      -- "none"   : nvim 内でターミナルを開かない（tmux 等で自分管理するとき）
      provider = "auto",

      -- Claude ターミナルを閉じたとき、バッファも自動で削除するか
      auto_close = true,

      -- snacks.nvim を使う場合の追加オプション
      -- floating window にしたい場合はここを設定する（後述のコメント参照）
      snacks_win_opts = {},
    },

    -- ============================================================
    -- Diff 設定
    -- ============================================================
    diff_opts = {
      -- diff を `:w` で accept したとき、diff ウィンドウを自動で閉じるか
      auto_close_on_accept = true,

      -- diff を縦分割で開くか（false にすると横分割）
      vertical_split = true,

      -- diff を現在のタブで開くか（false にすると新しいタブ）
      open_in_current_tab = true,

      -- diff が開いた後、フォーカスを Claude ターミナル側に戻すか
      -- true にすると diff を確認しながら Claude に追加指示を出しやすい
      keep_terminal_focus = false,
    },
  },

  -- ============================================================
  -- キーマップ
  -- ============================================================
  keys = {
    -- NOTE: 以前ここに `{ "<leader>c", nil, desc = "AI / Claude Code" }` を置いていたが、
    -- lazy.nvim が <leader>c に no-op マッピングを登録してしまい、timeoutlen 経過後に
    -- 残りの `c` と合わさって `cc` (change line) が発動する不具合があったため削除。
    -- which-key のグループ名は子キーの desc から推定される。

    -- Claude ターミナルをトグル（開いてなければ開く、開いていれば閉じる）
    { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },

    -- すでに開いているときはフォーカス移動、閉じているときは開く
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },

    -- 新しいセッションを作成
    -- 既存の Claude ターミナルを閉じて（プロセスごと終了）、引数なしで起動し直すことで
    -- --resume/--continue なしの新規セッションが始まる
    {
      "<leader>cn",
      function()
        vim.cmd("ClaudeCodeClose")
        vim.defer_fn(function() vim.cmd("ClaudeCodeOpen") end, 100)
      end,
      desc = "New Claude session",
    },

    -- 前のセッションを再開（--resume オプション）
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },

    -- 前の会話を続ける（--continue オプション）
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },

    -- 使用する Claude モデルを選択する
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Model" },

    -- 現在のバッファを Claude のコンテキストに追加
    -- % は現在のファイルパスに展開される
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },

    -- ビジュアル選択中のテキストを Claude に送信
    { "<leader>cs", "<cmd>ClaudeCodeSend<cr>",        mode = "v", desc = "Send selection to Claude" },

    -- ファイラー（nvim-tree / neo-tree / oil / mini.files / netrw）上で
    -- カーソル下のファイルを Claude のコンテキストに追加
    {
      "<leader>cs",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file from tree",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },

    -- Claude が提案した diff を承認（:w と同じ効果）
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>",  desc = "Accept diff" },

    -- Claude が提案した diff を却下（:q と同じ効果）
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",    desc = "Deny diff" },
  },
}
