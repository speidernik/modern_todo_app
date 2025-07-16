import { Todo } from '../types/todo';

interface TodoItemProps {
    todo: Todo;
    onDelete: (id: string) => void;
    onToggle: (id: string) => void;
} 