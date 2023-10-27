import {Controller} from "@hotwired/stimulus"
import {Sortable} from "sortablejs";
import {patch} from '@rails/request.js'


// Connects to data-controller="lists"
export default class extends Controller {
    static targets = ['list', 'task', 'listDragHandle', 'taskDragHandle']

    connect() {
        // setup sortable
        this.sortable_lists = new Sortable(this.element, {
            animation: 200,
            delay: 100,
            delayOnTouchOnly: true,
            touchStartThreshold: 5,
            handle: '[data-lists-target="listDragHandle"]',
            draggable: '[data-lists-target="list"]',
            forceFallback: true,

            onEnd: async (e) => {
                const newIndex = e.newIndex
                const path = e.item.dataset.reorderPath

                if (path) {
                    const response = await patch(path, {
                        body: JSON.stringify({'board_order_position': newIndex})
                    })

                    if (response.ok) {
                        console.log('List reordered')
                    }
                }
            }

        })

        this.sortable_list_tasks = []
        this.listTargets.forEach((list) => {
            this.sortable_list_tasks.push(
                new Sortable(list.children[1], {
                    group: 'shared',
                    animation: 200,
                    delay: 100,
                    touchStartThreshold: 5,
                    delayOnTouchOnly: true,
                    handle: '[data-lists-target="taskDragHandle"]',
                    draggable: '[data-lists-target="task"]',
                    forceFallback: true,


                    onEnd: async (e) => {
                        const list_id = parseInt(e.to.parentNode.id.split('_')[1])
                        const path = e.item.dataset.reorderPath
                        const newIndex = e.newIndex

                        if (path && list_id) {
                            const response = await patch(path, {
                                body: JSON.stringify({'list_order_position': newIndex, 'list_id': list_id})
                            })

                            if (response.ok) {
                                console.log('Task reordered')
                            }
                        }
                    }
                })
            )
        })
    }

    disconnect() {


        this.sortable_lists = []
        this.sortable_list_tasks = []
    }
}
