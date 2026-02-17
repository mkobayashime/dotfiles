export const NotificationPlugin = async ({ project, $ }) => {
	return {
		event: async ({ event }) => {
			if (event.type === "session.idle") {
				await $`terminal-notifier -title "opencode: ${project}" -message 'Task completed' -sound Glass -activate org.alacritty`;
			}
		},
	};
};
