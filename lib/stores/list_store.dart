import 'package:mobx/mobx.dart';

part 'list_store.g.dart';

class ListStore = _ListStore with _$ListStore;

abstract class _ListStore with Store {
  @observable
  String newTodoTitle = "";

  ObservableList<String> todoList = ObservableList<String>();

  @action
  void setNewTodoTitle(String valeu) {
    newTodoTitle = valeu;
  }

  @computed
  bool get isNewTodoTitleValid {
    return newTodoTitle.isNotEmpty;
  }

  @action
  void addTodo() {
    todoList.add(newTodoTitle);
    newTodoTitle = "";
  }
}
