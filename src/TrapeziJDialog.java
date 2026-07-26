/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.sql.SQLException;
import javax.swing.JOptionPane;

/**
 *
 * @author WiZ14
 */
public class TrapeziJDialog extends javax.swing.JDialog {

    /**
     * Creates new form TrapeziJDialog
     */
    public TrapeziJDialog(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
    }
    public void insertTrapeziAction() {
String query1="INSERT INTO Trapezi(TID,FLOOR,AREA,TIMESRESERVED,CAT) " +
                    "VALUES("+ 
                    "'"+JtidText.getText()+"',"+
                    "'"+JfloorText.getText()+"',"+
                    "'"+JareaText.getText()+"',"+
                    "'"+JtimesreservedText.getText()+"',"+
                    "'"+JcatText.getText()+"')"
                    
                ;
        
        System.out.println(query1);
        
        java.sql.Statement insertStmt;
        try {
            insertStmt =  DeliciousJframe.con.createStatement();
            insertStmt.executeQuery(query1);
            insertStmt.close();
        }
        catch( java.sql.SQLException e4) {
             JOptionPane.showMessageDialog( this , e4.getMessage() );
        }
        
    }
    public void updateTrapeziAction() {
        String query2="UPDATE Trapezi "+
                "SET FLOOR='"+JfloorText.getText()+"',"+
                "AREA='"+JareaText.getText()+"',"+
                "TIMESRESERVED='"+JtimesreservedText.getText()+"',"+
                "CAT='"+JcatText.getText()+"'"+
                "WHERE TID="+JtidText.getText();
                
System.out.println(query2);
        java.sql.Statement updateStm;
                try {
            updateStm =  DeliciousJframe.con.createStatement();
            updateStm.executeQuery(query2);
            updateStm.close();
        }
        catch( java.sql.SQLException e5) {
             JOptionPane.showMessageDialog( this , e5.getMessage() );
        }
    }
     public void deleteTrapeziAction() {
        String query3="DELETE FROM Trapezi WHERE TID="+JtidText.getText();
             
                

        System.out.println(query3);

        java.sql.Statement deleteStm;
                try{deleteStm=DeliciousJframe.con.createStatement();
                deleteStm.executeQuery(query3);
                deleteStm.close();}
                catch(SQLException e6){
                    JOptionPane.showMessageDialog(this,e6.getMessage());}
        
        
    }
     public void clearTable(javax.swing.table.DefaultTableModel model){
         int numrows =model.getRowCount();
         for (int i =numrows-1;i>=0;i--){
             model.removeRow(i);
         }
     }
     public void loadcustomers(){
        String query4="SELECT tid,floor,area,"
                + "TIMESRESERVED,cat FROM Trapezi "
                + "ORDER BY floor";
     
        
        java.sql.Statement searchStm;
        java.sql.ResultSet searchRS;
                try{
                    searchStm=DeliciousJframe.con.createStatement(
                        java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
                        java.sql.ResultSet.CONCUR_READ_ONLY);
                searchRS=searchStm.executeQuery(query4);
              clearTable((javax.swing.table.DefaultTableModel)JCustomersTable.getModel());
                while(searchRS.next()){
       ((javax.swing.table.DefaultTableModel) JCustomersTable.getModel()).addRow(
        new Object[]{
           searchRS.getString("TID"),
           searchRS.getString("floor"),
           searchRS.getString("area"),
           searchRS.getString("TIMESRESERVED"),
           searchRS.getString("cat")
       });
                   
               }searchRS.close();
                searchStm.close();}
                catch(SQLException e7){
                    JOptionPane.showMessageDialog(this,e7.getMessage());}
        }
      public void resetButtonAction(){
         JcatText.setText("");
         JtidText.setText("");
         JfloorText.setText("");
         JareaText.setText("");
         JtimesreservedText.setText("");
     } public void TableMouseClickedAction(){
        if((JCustomersTable.getSelectedRow() )<0)return;
JtidText.setText(""+JCustomersTable.getModel().getValueAt(JCustomersTable.getSelectedRow(),0));
JfloorText.setText(""+JCustomersTable.getModel().getValueAt(JCustomersTable.getSelectedRow(),1));
JareaText.setText(""+JCustomersTable.getModel().getValueAt(JCustomersTable.getSelectedRow(),2));
JtimesreservedText.setText(""+JCustomersTable.getModel().getValueAt(JCustomersTable.getSelectedRow(),3));
JcatText.setText(""+JCustomersTable.getModel().getValueAt(JCustomersTable.getSelectedRow(),4));}
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        JCustomersTable = new javax.swing.JTable();
        jLabel1 = new javax.swing.JLabel();
        JPIDLabel = new javax.swing.JLabel();
        JLastnameLabel = new javax.swing.JLabel();
        JFirstnameLabel = new javax.swing.JLabel();
        JRegdateLabel = new javax.swing.JLabel();
        JIDLabel = new javax.swing.JLabel();
        JinsertButton = new javax.swing.JButton();
        JupdateButton = new javax.swing.JButton();
        JdeleteButton = new javax.swing.JButton();
        JtidText = new javax.swing.JTextField();
        JfloorText = new javax.swing.JTextField();
        JareaText = new javax.swing.JTextField();
        JtimesreservedText = new javax.swing.JTextField();
        JcatText = new javax.swing.JTextField();
        JResetButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                formComponentShown(evt);
            }
        });

        JCustomersTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "TID", "Floor", "Area", "TimesReserved", "TableCategory"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        JCustomersTable.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JCustomersTableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(JCustomersTable);

        jLabel1.setText("Tables");

        JPIDLabel.setText("TID");

        JLastnameLabel.setText("Floor");
        JLastnameLabel.setToolTipText("");

        JFirstnameLabel.setText("Area");

        JRegdateLabel.setText("TimesReserved");

        JIDLabel.setText("TableCategory");

        JinsertButton.setText("Insert");
        JinsertButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JinsertButtonActionPerformed(evt);
            }
        });

        JupdateButton.setText("Update");
        JupdateButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JupdateButtonActionPerformed(evt);
            }
        });

        JdeleteButton.setText("Delete");
        JdeleteButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JdeleteButtonActionPerformed(evt);
            }
        });

        JfloorText.setToolTipText("");

        JtimesreservedText.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JtimesreservedTextActionPerformed(evt);
            }
        });

        JcatText.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JcatTextActionPerformed(evt);
            }
        });

        JResetButton.setText("Reset");
        JResetButton.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JResetButtonActionPerformed(evt);
            }
        });

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
        getContentPane().setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(JLastnameLabel)
                                .addGap(18, 18, 18)
                                .addComponent(JfloorText, javax.swing.GroupLayout.PREFERRED_SIZE, 62, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(JPIDLabel)
                                .addGap(18, 18, 18)
                                .addComponent(JtidText, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 235, Short.MAX_VALUE)
                        .addComponent(JinsertButton))
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(JFirstnameLabel)
                                .addGap(18, 18, 18)
                                .addComponent(JareaText, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(JIDLabel)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                .addComponent(JcatText, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addComponent(JupdateButton, javax.swing.GroupLayout.Alignment.TRAILING)
                            .addComponent(JResetButton, javax.swing.GroupLayout.Alignment.TRAILING)))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addComponent(JRegdateLabel)
                        .addGap(18, 18, 18)
                        .addComponent(JtimesreservedText, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(JdeleteButton)
                        .addGap(10, 10, 10)))
                .addContainerGap())
            .addGroup(layout.createSequentialGroup()
                .addContainerGap()
                .addComponent(jLabel1)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JPIDLabel)
                            .addComponent(JtidText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JLastnameLabel)
                            .addComponent(JfloorText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(JinsertButton)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JFirstnameLabel)
                            .addComponent(JareaText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JRegdateLabel)
                            .addComponent(JtimesreservedText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JIDLabel)
                            .addComponent(JcatText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 36, Short.MAX_VALUE)
                        .addComponent(jLabel1)
                        .addGap(26, 26, 26))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(JupdateButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(JdeleteButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addComponent(JResetButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)))
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void JcatTextActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JcatTextActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JcatTextActionPerformed

    private void JinsertButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JinsertButtonActionPerformed
        // TODO add your handling code here:
        insertTrapeziAction();
        loadcustomers();
    }//GEN-LAST:event_JinsertButtonActionPerformed

    private void JupdateButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JupdateButtonActionPerformed
        // TODO add your handling code here:
        updateTrapeziAction();loadcustomers();
    }//GEN-LAST:event_JupdateButtonActionPerformed

    private void JdeleteButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JdeleteButtonActionPerformed
        // TODO add your handling code here:
        deleteTrapeziAction();loadcustomers();
    }//GEN-LAST:event_JdeleteButtonActionPerformed

    private void formComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentShown
        // TODO add your handling code here:
        loadcustomers();
    }//GEN-LAST:event_formComponentShown

    private void JtimesreservedTextActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JtimesreservedTextActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JtimesreservedTextActionPerformed

    private void JResetButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JResetButtonActionPerformed
        // TODO add your handling code here:
        resetButtonAction();
    }//GEN-LAST:event_JResetButtonActionPerformed

    private void JCustomersTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JCustomersTableMouseClicked
        // TODO add your handling code here:
        TableMouseClickedAction();
    }//GEN-LAST:event_JCustomersTableMouseClicked

    /**
     * @param args the command line arguments
     */
    public static void main(String args[]) {
        /* Set the Nimbus look and feel */
        //<editor-fold defaultstate="collapsed" desc=" Look and feel setting code (optional) ">
        /* If Nimbus (introduced in Java SE 6) is not available, stay with the default look and feel.
         * For details see http://download.oracle.com/javase/tutorial/uiswing/lookandfeel/plaf.html 
         */
        try {
            for (javax.swing.UIManager.LookAndFeelInfo info : javax.swing.UIManager.getInstalledLookAndFeels()) {
                if ("Nimbus".equals(info.getName())) {
                    javax.swing.UIManager.setLookAndFeel(info.getClassName());
                    break;
                }
            }
        } catch (ClassNotFoundException ex) {
            java.util.logging.Logger.getLogger(TrapeziJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(TrapeziJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(TrapeziJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(TrapeziJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                TrapeziJDialog dialog = new TrapeziJDialog(new javax.swing.JFrame(), true);
                dialog.addWindowListener(new java.awt.event.WindowAdapter() {
                    @Override
                    public void windowClosing(java.awt.event.WindowEvent e) {
                        System.exit(0);
                    }
                });
                dialog.setVisible(true);
            }
        });
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JTable JCustomersTable;
    private javax.swing.JLabel JFirstnameLabel;
    private javax.swing.JLabel JIDLabel;
    private javax.swing.JLabel JLastnameLabel;
    private javax.swing.JLabel JPIDLabel;
    private javax.swing.JLabel JRegdateLabel;
    private javax.swing.JButton JResetButton;
    private javax.swing.JTextField JareaText;
    private javax.swing.JTextField JcatText;
    private javax.swing.JButton JdeleteButton;
    private javax.swing.JTextField JfloorText;
    private javax.swing.JButton JinsertButton;
    private javax.swing.JTextField JtidText;
    private javax.swing.JTextField JtimesreservedText;
    private javax.swing.JButton JupdateButton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables
}
