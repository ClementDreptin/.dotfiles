;; Custom treesitter injection to fix bash syntax highlighting inside Dockerfiles.
;; This fixed injection was found in this PR: https://github.com/nvim-treesitter/nvim-treesitter/pull/8571.
;;
;; TODO:
;; - remove this custom injection once the PR is merged (or the problem is fixed in another way).

((comment) @injection.content
  (#set! injection.language "comment"))

((run_instruction
  (shell_command) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))

((run_instruction
  (heredoc_block) @injection.content)
  (#set! injection.language "bash")
  (#set! injection.include-children))
