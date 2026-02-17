txd = engineLoadTXD("quad.txd")
engineImportTXD(txd, 211)
dff = engineLoadDFF("quad.dff", 211)
engineReplaceModel(dff, 211)



