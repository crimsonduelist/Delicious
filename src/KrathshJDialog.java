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
public class KrathshJDialog extends javax.swing.JDialog {

    /**
     * Creates new form TrapeziJDialog
     */
    public KrathshJDialog(java.awt.Frame parent, boolean modal) {
        super(parent, modal);
        initComponents();
    }
    public void insertkrathshAction() {
String query1="INSERT INTO KRATHSH(KID,INDATE,OUTDATE,BILL,PID,TID,ReservationNO) " +
                    "VALUES("+ 
                   "'"+JkidText.getText()+"',"+
                  
                    "TO_DATE('"+JindateText.getText()+"','DD-MM-YY HH24:MI:SS')"+","+
                    "TO_DATE('"+JoutdateText.getText()+"','DD-MM-YY HH24:MI:SS')"+","+
                     
                    "'"+JbillText.getText()+"',"+
                    "'"+JpidText.getText()+"'"+
                    ",'"+JtidText.getText()+"',"+
                    "CUSTSEQ.nextval)"
                    
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
    public void updatekrathshAction() {
        String query2="UPDATE Krathsh "+
                "SET TID='"+JtidText.getText()+"',"+
                
                "BILL='"+JbillText.getText()+"',"+
                "INDATE="+"TO_DATE('"+JindateText.getText()+"','DD/MM/YY HH24:MI:SS')"+" "+
                ",OUTDATE="+"TO_DATE('"+JoutdateText.getText()+"','DD/MM/YY HH24:MI:SS')"+" "+
                "WHERE kid="+JkidText.getText();
                
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
     public void deletekrathshAction() {
        String query3="DELETE FROM KRATHSH WHERE KID="+JkidText.getText();
             
                

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
        String query4="SELECT PID,TID,KID,"
                + "indate,outdate,BILL,ReservationNO FROM krathsh "
                + "ORDER BY KID";
     
        
        java.sql.Statement searchStm;
        java.sql.ResultSet searchRS;
                try{
                    searchStm=DeliciousJframe.con.createStatement(
                        java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,
                        java.sql.ResultSet.CONCUR_READ_ONLY);
                searchRS=searchStm.executeQuery(query4);
              clearTable((javax.swing.table.DefaultTableModel)JKrathshTable.getModel());
                while(searchRS.next()){
       ((javax.swing.table.DefaultTableModel) JKrathshTable.getModel()).addRow(
        new Object[]{
           searchRS.getString("pid"),
           searchRS.getString("tid"),
           searchRS.getString("kid"),
           searchRS.getString("indate"),
           searchRS.getString("outdate"),
           searchRS.getString("bill"),
           searchRS.getString("ReservationNO")
                
       });
                   
               }searchRS.close();
                searchStm.close();}
                catch(SQLException e7){
                    JOptionPane.showMessageDialog(this,e7.getMessage());}
        }
      public void resetButtonAction(){
         JpidText.setText("");
         JtidText.setText("");
         JkidText.setText("");
         JoutdateText.setText("");
         JindateText.setText("");
         JbillText.setText("");
         
     }
      public void TableMouseClickedAction(){
        if((JKrathshTable.getSelectedRow() )<0)return;
JpidText.setText(""+JKrathshTable.getModel().getValueAt(JKrathshTable.getSelectedRow(),0));
JtidText.setText(""+JKrathshTable.getModel().getValueAt(JKrathshTable.getSelectedRow(),1));
JkidText.setText(""+JKrathshTable.getModel().getValueAt(JKrathshTable.getSelectedRow(),2));
JindateText.setText(""+JKrathshTable.getModel().getValueAt(JKrathshTable.getSelectedRow(),3));
JoutdateText.setText(""+JKrathshTable.getModel().getValueAt(JKrathshTable.getSelectedRow(),4));
JbillText.setText(""+JKrathshTable.getModel().getValueAt(JKrathshTable.getSelectedRow(),5));}
    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */
    @SuppressWarnings("unchecked")
    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        jScrollPane1 = new javax.swing.JScrollPane();
        JKrathshTable = new javax.swing.JTable();
        jLabel1 = new javax.swing.JLabel();
        JPIDLabel = new javax.swing.JLabel();
        JLastnameLabel = new javax.swing.JLabel();
        JFirstnameLabel = new javax.swing.JLabel();
        JRegdateLabel = new javax.swing.JLabel();
        JIDLabel = new javax.swing.JLabel();
        JinsertButton = new javax.swing.JButton();
        JupdateButton = new javax.swing.JButton();
        JdeleteButton = new javax.swing.JButton();
        JpidText = new javax.swing.JTextField();
        JtidText = new javax.swing.JTextField();
        JkidText = new javax.swing.JTextField();
        JindateText = new javax.swing.JTextField();
        JbillText = new javax.swing.JTextField();
        JOutdateLabel = new javax.swing.JLabel();
        JoutdateText = new javax.swing.JTextField();
        JResetButton = new javax.swing.JButton();

        setDefaultCloseOperation(javax.swing.WindowConstants.DISPOSE_ON_CLOSE);
        addComponentListener(new java.awt.event.ComponentAdapter() {
            public void componentShown(java.awt.event.ComponentEvent evt) {
                formComponentShown(evt);
            }
        });

        JKrathshTable.setModel(new javax.swing.table.DefaultTableModel(
            new Object [][] {

            },
            new String [] {
                "CustomerID", "TableID", "ResID", "Indate", "Outdate", "Bill", "ResNo"
            }
        ) {
            Class[] types = new Class [] {
                java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class, java.lang.String.class
            };
            boolean[] canEdit = new boolean [] {
                false, false, false, false, false, false, false
            };

            public Class getColumnClass(int columnIndex) {
                return types [columnIndex];
            }

            public boolean isCellEditable(int rowIndex, int columnIndex) {
                return canEdit [columnIndex];
            }
        });
        JKrathshTable.addMouseListener(new java.awt.event.MouseAdapter() {
            public void mouseClicked(java.awt.event.MouseEvent evt) {
                JKrathshTableMouseClicked(evt);
            }
        });
        jScrollPane1.setViewportView(JKrathshTable);

        jLabel1.setText("Reservations");

        JPIDLabel.setText("CustomerID");

        JLastnameLabel.setText("TableID");
        JLastnameLabel.setToolTipText("");

        JFirstnameLabel.setText("ResID");

        JRegdateLabel.setText("Indate");

        JIDLabel.setText("Bill");

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

        JtidText.setToolTipText("");

        JbillText.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JbillTextActionPerformed(evt);
            }
        });

        JOutdateLabel.setText("Outdate");

        JoutdateText.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                JoutdateTextActionPerformed(evt);
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
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(JLastnameLabel)
                                .addGap(18, 18, 18)
                                .addComponent(JtidText, javax.swing.GroupLayout.PREFERRED_SIZE, 62, javax.swing.GroupLayout.PREFERRED_SIZE))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(JPIDLabel)
                                .addGap(18, 18, 18)
                                .addComponent(JpidText, javax.swing.GroupLayout.PREFERRED_SIZE, 37, javax.swing.GroupLayout.PREFERRED_SIZE)))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(JinsertButton))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(JFirstnameLabel)
                        .addGap(18, 18, 18)
                        .addComponent(JkidText, javax.swing.GroupLayout.PREFERRED_SIZE, 50, javax.swing.GroupLayout.PREFERRED_SIZE)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                        .addComponent(JupdateButton))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE))
                    .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                        .addContainerGap()
                                        .addComponent(JIDLabel)
                                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                                        .addComponent(JbillText, javax.swing.GroupLayout.PREFERRED_SIZE, 45, javax.swing.GroupLayout.PREFERRED_SIZE))
                                    .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                        .addComponent(JOutdateLabel)
                                        .addGap(18, 18, 18)
                                        .addComponent(JoutdateText, javax.swing.GroupLayout.PREFERRED_SIZE, 151, javax.swing.GroupLayout.PREFERRED_SIZE)))
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
                                .addComponent(JResetButton))
                            .addGroup(layout.createSequentialGroup()
                                .addGap(0, 0, Short.MAX_VALUE)
                                .addComponent(JRegdateLabel)
                                .addGap(18, 18, 18)
                                .addComponent(JindateText, javax.swing.GroupLayout.PREFERRED_SIZE, 146, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(131, 131, 131)
                                .addComponent(JdeleteButton)))
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
                            .addComponent(JpidText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JLastnameLabel)
                            .addComponent(JtidText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)))
                    .addGroup(layout.createSequentialGroup()
                        .addContainerGap()
                        .addComponent(JinsertButton)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JFirstnameLabel)
                            .addComponent(JkidText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JRegdateLabel)
                            .addComponent(JindateText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JOutdateLabel)
                            .addComponent(JoutdateText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE))
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 7, Short.MAX_VALUE)
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
                            .addComponent(JbillText, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                            .addComponent(JIDLabel))
                        .addGap(26, 26, 26)
                        .addComponent(jLabel1))
                    .addGroup(layout.createSequentialGroup()
                        .addComponent(JupdateButton)
                        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
                        .addComponent(JdeleteButton)
                        .addGap(18, 18, 18)
                        .addComponent(JResetButton)
                        .addGap(0, 0, Short.MAX_VALUE)))
                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
                .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 89, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap())
        );

        pack();
    }// </editor-fold>//GEN-END:initComponents

    private void JbillTextActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JbillTextActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JbillTextActionPerformed

    private void JinsertButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JinsertButtonActionPerformed
        // TODO add your handling code here:
        insertkrathshAction();loadcustomers();
    }//GEN-LAST:event_JinsertButtonActionPerformed

    private void JupdateButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JupdateButtonActionPerformed
        // TODO add your handling code here:
        updatekrathshAction();loadcustomers();
    }//GEN-LAST:event_JupdateButtonActionPerformed

    private void JdeleteButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JdeleteButtonActionPerformed
        // TODO add your handling code here:
        deletekrathshAction();loadcustomers();
        
    }//GEN-LAST:event_JdeleteButtonActionPerformed

    private void formComponentShown(java.awt.event.ComponentEvent evt) {//GEN-FIRST:event_formComponentShown
        // TODO add your handling code here:
        loadcustomers();
    }//GEN-LAST:event_formComponentShown

    private void JoutdateTextActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JoutdateTextActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_JoutdateTextActionPerformed

    private void JResetButtonActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_JResetButtonActionPerformed
        // TODO add your handling code here:
        resetButtonAction();
    }//GEN-LAST:event_JResetButtonActionPerformed

    private void JKrathshTableMouseClicked(java.awt.event.MouseEvent evt) {//GEN-FIRST:event_JKrathshTableMouseClicked
        // TODO add your handling code here:
        TableMouseClickedAction();
    }//GEN-LAST:event_JKrathshTableMouseClicked

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
            java.util.logging.Logger.getLogger(KrathshJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            java.util.logging.Logger.getLogger(KrathshJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            java.util.logging.Logger.getLogger(KrathshJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        } catch (javax.swing.UnsupportedLookAndFeelException ex) {
            java.util.logging.Logger.getLogger(KrathshJDialog.class.getName()).log(java.util.logging.Level.SEVERE, null, ex);
        }
        //</editor-fold>
        //</editor-fold>

        /* Create and display the dialog */
        java.awt.EventQueue.invokeLater(new Runnable() {
            public void run() {
                KrathshJDialog dialog = new KrathshJDialog(new javax.swing.JFrame(), true);
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
    private javax.swing.JLabel JFirstnameLabel;
    private javax.swing.JLabel JIDLabel;
    private javax.swing.JTable JKrathshTable;
    private javax.swing.JLabel JLastnameLabel;
    private javax.swing.JLabel JOutdateLabel;
    private javax.swing.JLabel JPIDLabel;
    private javax.swing.JLabel JRegdateLabel;
    private javax.swing.JButton JResetButton;
    private javax.swing.JTextField JbillText;
    private javax.swing.JButton JdeleteButton;
    private javax.swing.JTextField JindateText;
    private javax.swing.JButton JinsertButton;
    private javax.swing.JTextField JkidText;
    private javax.swing.JTextField JoutdateText;
    private javax.swing.JTextField JpidText;
    private javax.swing.JTextField JtidText;
    private javax.swing.JButton JupdateButton;
    private javax.swing.JLabel jLabel1;
    private javax.swing.JScrollPane jScrollPane1;
    // End of variables declaration//GEN-END:variables
}
