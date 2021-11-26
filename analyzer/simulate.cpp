#include <vector>
#include <queue>
#include <string>
#include <iostream>

struct instruction {
	std::string label; // "put" or "get"
	std::vector<int> points_to_set; // promises referenced by "put" or "get"
};

using function = std::queue<instruction>; // the thread function type

int main() {
	std::vector<int> promise_status; // initially, all promises are unset (== 0)
	std::queue<function> active_threads;

	while (true) {
		bool has_progress = false;

		int n = active_threads.size();
		for (int i = 0; i < n; i++) { // round robin: try one instruction for each thread
			auto thread = active_threads.front();
			active_threads.pop();

			auto inst = thread.front();
			if (inst.label == "put") {
				for (int promise : inst.points_to_set) {
					promise_status[promise] = 1;
				}
				thread.pop();
				has_progress = true;
			} else if (inst.label == "get") {
				bool can_get = true;
				for (int promise : inst.points_to_set) {
					if (promise_status[promise] == 0) {
						can_get = false;
					}
				}
				if (can_get) {
					thread.pop();
					has_progress = true;
				}
			}
			if (!thread.empty()) { // if not finished, put it back to the queue
				active_threads.push(thread);
			}
		}
		if (active_threads.size() == 0) { // no active thread after the current round
			std::cout << "no deadlock detected" << std::endl;
			break;
		}
		if (!has_progress) { // no thread can proceed in the current round
			std::cout << "deadlock detected" << std::endl;
			break;
		}
	}
}
