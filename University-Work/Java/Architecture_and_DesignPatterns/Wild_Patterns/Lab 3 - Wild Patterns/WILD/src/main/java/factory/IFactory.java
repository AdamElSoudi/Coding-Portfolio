package factory;

import controllers.MainWindowController;

public interface IFactory {
    ICommunicator createComm(String type, MainWindowController chat);
}
