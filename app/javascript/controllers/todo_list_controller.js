import { Controller } from "@hotwired/stimulus"
import { Sortable } from "sortablejs"

export default class extends Controller {
  connect() {
    this.sortable = Sortable.create(this.element, {
      animation: 150,
      onEnd: this.updatePosition.bind(this)
    })
  }

  async updatePosition(event) {
    const taskId = event.item.dataset.taskId
    const newIndex = event.newIndex
    const todoListId = this.element.dataset.todoListId

    await fetch(`/todo_lists/${todoListId}/tasks/${taskId}/update_position`, {
      method: "PATCH",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content
      },
      body: JSON.stringify({ position: newIndex + 1 })
    })
  }
}